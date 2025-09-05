//  Created by Kristina Grebneva on 04.09.2025.

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import GoogleSignIn

@MainActor
final class SignInViewModel: NSObject, ObservableObject {
    @Published var isLoading = false
    @Published var error: String?
    @Published var user: User?
    
    private var authListenerHandle: AuthStateDidChangeListenerHandle?
    private var currentNonce: String?
    private var appleController: ASAuthorizationController?
    private let endpoint = "https://api.court360.ai/rpc/client"
    private let fallbackEndpoint = "https://mpd13c6c586060fd5c82.free.beeceptor.com"
    
    var onSignedIn: ((String) -> Void)?
    
    deinit {
        if let h = authListenerHandle { Auth.auth().removeStateDidChangeListener(h) }
    }
    
    // MARK: - Public API
    
    func startAuthStateListener() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in self?.user = user }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            user = nil
            onSignedIn?("")
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    // MARK: - Google
    
    func signInWithGoogle(presenting viewController: UIViewController) async {
        isLoading = true
        error = nil
        defer { isLoading = false }
        
        do {
            let gidResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: viewController)
            guard let idToken = gidResult.user.idToken?.tokenString else { throw AuthError.missingIDToken }
            let accessToken = gidResult.user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            let _ = try await Auth.auth().signIn(with: credential)
            
            try await sendIDTokenToServer()
        } catch {
            self.error = userMessage(error)
        }
    }
    
    // MARK: - Sign in with Apple
    
    func signInWithApple() {
        isLoading = true
        error = nil
        
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        self.appleController = controller
        controller.performRequests()
    }
    
    // MARK: - Token helper (Firebase ID Token)
    
    func fetchFirebaseIDToken(forcingRefresh: Bool = false) async throws -> String? {
        guard let user = Auth.auth().currentUser else { return nil }
        return try await withCheckedThrowingContinuation { cont in
            user.getIDTokenForcingRefresh(forcingRefresh) { token, error in
                if let token { cont.resume(returning: token) }
                else { cont.resume(throwing: error ?? NSError(domain: "Auth", code: -1)) }
            }
        }
    }
    
    // MARK: - Errors, nonce, sha256
    
    enum AuthError: LocalizedError { case missingIDToken }
    
    private func userMessage(_ error: Error) -> String {
        // Apple
        if let apple = error as? ASAuthorizationError {
            switch apple.code {
            case .canceled: return "Sign-in was cancelled."
            default: return error.localizedDescription
            }
        }
        
        // Google
        let ns = error as NSError
        if ns.domain.contains("com.google.GIDSignIn") {
            if ns.code == -5 { return "Sign-in was cancelled." }
            return ns.localizedDescription
        }
        
        // Firebase Auth
        if ns.domain == AuthErrorDomain {
            let auth = AuthErrorCode(_bridgedNSError: ns)
            switch auth?.code {
            case .networkError:
                return "Network error. Try again."
            case .credentialAlreadyInUse:
                return "This credential is already in use."
            case .userDisabled:
                return "Account is disabled."
            case .webContextCancelled, .webContextAlreadyPresented:
                return "Sign-in was cancelled."
            case .invalidCredential, .invalidCustomToken, .invalidEmail:
                return "Invalid credentials."
            default:
                return ns.localizedDescription
            }
        }
        
        // Other
        return ns.localizedDescription
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length
        
        while remaining > 0 {
            var random: UInt8 = 0
            let status = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if status != errSecSuccess { fatalError("Unable to generate nonce.") }
            if random < charset.count {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
    
    // MARK: - Network request
    
    private func sendIDTokenToServer() async throws {
        guard let firebaseToken = try await fetchFirebaseIDToken() else { throw NetworkError.missingAccessToken }
        
        #if DEBUG
            let baseURLString = fallbackEndpoint
            let tokenToSend = "<redacted>"
        #else
            let baseURLString = endpoint
            let tokenToSend = firebaseToken
        #endif
        
        guard let url = URL(string: baseURLString) else { throw NetworkError.invalidURL }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.timeoutInterval = 15
        
        let rpc = JSONRequest(
            method: "auth.firebaseLogin",
            params: FirebaseLoginParams(fbIdToken: tokenToSend),
            id: 1
        )
        req.httpBody = try JSONEncoder().encode(rpc)
        
        let (data, resp) = try await URLSession.shared.data(for: req)
        
        if let http = resp as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw NetworkError.httpStatus(http.statusCode, body)
        }
        
        if let rpcErr = try? JSONDecoder().decode(JSONError.self, from: data) {
            throw NetworkError.rpc("\(rpcErr.error.code): \(rpcErr.error.message)")
        }
        
        let success = try? JSONDecoder().decode(JSONSuccess<JSONResult>.self, from: data)
        guard let result = success?.result else { throw NetworkError.decodingFailed }
        
        onSignedIn?(result.accessToken)
    }
}

// MARK: - Apple Delegates

extension SignInViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first ?? UIWindow()
    }

    func authorizationController(controller: ASAuthorizationController,
                                             didCompleteWithAuthorization authorization: ASAuthorization) {
        Task { @MainActor in
            guard
                let apple = authorization.credential as? ASAuthorizationAppleIDCredential,
                let tokenData = apple.identityToken,
                let idToken = String(data: tokenData, encoding: .utf8),
                let nonce = currentNonce
            else {
                self.error = "Apple ID token missing"; return
            }

            self.isLoading = true; defer { self.isLoading = false }
            self.currentNonce = nil
            self.appleController = nil

            let credential = OAuthProvider.appleCredential(
                withIDToken: idToken,
                rawNonce: nonce,
                fullName: apple.fullName
            )

            do {
                let result = try await Auth.auth().signIn(with: credential)
                if let fullName = apple.fullName, !fullName.formatted().isEmpty {
                    let change = result.user.createProfileChangeRequest()
                    change.displayName = PersonNameComponentsFormatter().string(from: fullName)
                    try? await change.commitChanges()
                }
                
                try await sendIDTokenToServer()
            } catch {
                self.error = self.userMessage(error)
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController,
                                             didCompleteWithError error: Error) {
        Task { @MainActor in
            self.isLoading = false
            self.currentNonce = nil
            self.appleController = nil
            self.error = error.localizedDescription
        }
    }
}



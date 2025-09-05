//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct SignInScreen: View {
    let onSignedIn: (String) -> Void
    @StateObject private var vm = SignInViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack{
                welcomeBlock
                Spacer()
                authButtons
                terms
            }
            .padding()
            .background(background)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(DS.SignIn.skipButtonTitle, action: {
                        onSignedIn(AppKeys.Storage.skipToken)
                    })
                    .tint(.primary)
                }
            }
            .overlay { if vm.isLoading { ProgressView().controlSize(.large).tint(.primary) } }
            .alert(DS.SignIn.alertTitle,
                   isPresented: Binding(get: { vm.error != nil },
                                        set: { if !$0 { vm.error = nil } })) {
                Button(DS.SignIn.alertOkButtonTitle) { vm.error = nil }
            } message: { Text(vm.error ?? "") }
            .task {
                vm.startAuthStateListener()
                vm.onSignedIn = { token in
                    onSignedIn(token)
                }
            }
        }
    }
    
    private var welcomeBlock: some View {
        VStack(alignment: .leading) {
            Text(DS.SignIn.welcomeTitle)
                .padding(.bottom, 20)
                .foregroundStyle(.primary)
                .font(.custom(DS.Font.titleStyleFont, size: 45))
                .textCase(.uppercase)
            Text(DS.SignIn.welcomeSubtitle)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var authButtons: some View {
        VStack(spacing: 8) {
            SignInButton(kind: .apple, action: vm.signInWithApple)
            SignInButton(kind: .google, action: signInWithGoogle)
        }
        .padding(.bottom, 16)
    }
    
    private var terms: some View {
        VStack(alignment: .center) {
            Text(DS.SignIn.termsDescription)
            
            Text(DS.SignIn.terms)
                .foregroundStyle(.blue)
                .underline(true, color: .blue)
            + Text(DS.SignIn.and)
            + Text(DS.SignIn.privacy)
                .foregroundStyle(.blue)
                .underline(true, color: .blue)
        }
        .foregroundStyle(.primary)
    }
    
    private var background: some View {
        ZStack {
            colorScheme == .light ? Color.customLightBackground : Color.customDarkBackground
            Image(DS.SignIn.backgroundCircleImage)
                .foregroundStyle(colorScheme == .light ? Color.lightCircleBlue : Color.darkCircleBlue)
            Image(DS.SignIn.backgroundFlowerImage)
        }
        .ignoresSafeArea()
    }
    
    private func signInWithGoogle() {
        if let vc = UIApplication.shared.connectedScenes
                                    .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController })
                                    .first {
            Task { await vm.signInWithGoogle(presenting: vc) }
        }
    }
}

#Preview {
    NavigationStack {
        SignInScreen(onSignedIn: {_ in })
    }
}


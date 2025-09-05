//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

enum AppKeys {
    enum Storage {
        static let accessTokenKey = "authIDToken"
        static let skipToken = "skipToken"
    }
}

struct EntryView: View {
    @AppStorage(AppKeys.Storage.accessTokenKey) private var storedToken: String = ""
    @State private var didSkipThisSession = false

    private var shouldShowAuth: Bool { storedToken.isEmpty && !didSkipThisSession }

    var body: some View {
        ZStack {
            if shouldShowAuth {
                SignInScreen(onSignedIn: saveToken)
                .transition(.opacity)
                .zIndex(2)
            } else {
                MainScreen()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: shouldShowAuth)
    }
    
    private func saveToken(_ token: String) {
        if token == AppKeys.Storage.skipToken {
            didSkipThisSession = true
        } else {
            storedToken = token
        }
    }
}



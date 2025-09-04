//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct EntryView: View {
    @AppStorage("authIDToken") private var storedToken: String?

    var body: some View {
        ZStack {
            if let _ = storedToken {
                MainScreen()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                SignInScreen(
                    onSignedIn: { token in
                        storedToken = token
                    }
                )
                .transition(.opacity)
                .zIndex(2)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: storedToken != nil)
    }
}



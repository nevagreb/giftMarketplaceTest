//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct EntryView: View {
    @AppStorage("didFinishedSignIn") private var didFinishedSignIn: Bool = false
    
    var body: some View {
        Group {
            if didFinishedSignIn {
                MainScreen()
                    .transition(.opacity)
                    .zIndex(1)
            } else {
                SignInScreen(onSkip: skipSignIn)
                    .transition(.opacity)
                    .zIndex(2)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: didFinishedSignIn)
        .onAppear {
            UserDefaults.standard.removeObject(forKey: "didFinishedSignIn")
        }
    }
    
    func skipSignIn() {
        didFinishedSignIn = true
    }
}



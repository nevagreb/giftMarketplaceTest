//  Created by Kristina Grebneva on 04.09.2025.

import GoogleSignIn
import FirebaseCore
import SwiftUI

@main
struct GiftMarketplaceTestApp: App {
    
    init() {
        FirebaseApp.configure()
        
        if let clientID = FirebaseApp.app()?.options.clientID {
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        } else {
            assertionFailure("Missing Firebase clientID")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI


enum AppTab: Hashable {
    case gifts, flowers, events, cart, profile
}

struct MainScreen: View {
    @State private var selection: AppTab = .gifts
    
    var body: some View {
        TabView(selection: $selection) {
            GiftScreen()
                .tabItem {
                    VStack {
                        Text("Gifts")
                        Image("gift")
                    }
                }
                .tag(AppTab.gifts)
            
            Text("Gifts")
                .tabItem {
                    VStack {
                        Text("Gifts")
                        Image("tulip")
                    }
                }
                .tag(AppTab.flowers)
            
            Text("Events")
                .tabItem {
                    VStack {
                        Text("Events")
                        Image("events")
                    }
                }
                .tag(AppTab.events)
            
            Text("Cart")
                .tabItem {
                    VStack {
                        Text("Cart")
                        Image("cart")
                    }
                }
                .tag(AppTab.cart)
            
            Text("Profile")
                .tabItem {
                    VStack {
                        Text("Profile")
                        Image("profile")
                    }
                }
                .tag(AppTab.profile)
        }
        .onAppear(perform: setupTabBarAppearance)
        .tint(.primary)
    }
    
    // tabBar color customization
    private func setupTabBarAppearance() {
        let inactive = UIColor.tabBarColor
        let bg = UIColor.systemBackground
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = bg
        
        appearance.stackedLayoutAppearance.normal.iconColor = inactive
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: inactive]
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.label
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainScreen()
}

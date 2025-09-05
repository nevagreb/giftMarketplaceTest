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
                .tabItemView(for: .gifts)
                .tag(AppTab.gifts)
            
            Text(DS.TabBar.title(for: .flowers))
                .tabItemView(for: .flowers)
                .tag(AppTab.flowers)
            
            Text(DS.TabBar.title(for: .events))
                .tabItemView(for: .events)
                .tag(AppTab.events)
            
            Text(DS.TabBar.title(for: .cart))
                .tabItemView(for: .cart)
                .tag(AppTab.cart)
            
            Text(DS.TabBar.title(for: .profile))
                .tabItemView(for: .profile)
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





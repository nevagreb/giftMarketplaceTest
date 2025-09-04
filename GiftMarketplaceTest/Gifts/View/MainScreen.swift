//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI


enum AppTab: Hashable {
    case gifts, flowers, events, cart, profile
}

struct MainScreen: View {
    @State private var selection: AppTab = .gifts

    var body: some View {
        TabView(selection: $selection) {
            Text("Gifts").tabItem { Label("Gifts", systemImage: "gift.fill") }.tag(AppTab.gifts)
            Text("Gifts").tabItem { Label("Gifts", systemImage: "tulip") }.tag(AppTab.flowers) // iOS 17+
            Text("Events").tabItem { Label("Events", systemImage: "calendar.badge.checkmark") }.tag(AppTab.events)
            Text("Cart").tabItem { Label("Cart", systemImage: "basket") }.tag(AppTab.cart)
            Text("Profile").tabItem { Label("Profile", systemImage: "person.crop.circle") }.tag(AppTab.profile)
        }
        .onAppear(perform: setupTabBarAppearance) // цвета/фон
        .tint(.primary) // цвет выбранной иконки/текста (динамический под тему)
    }
}

// Настройка системного таббара (iOS 15+)
private func setupTabBarAppearance() {
    let inactive = UIColor(red: 118/255, green: 138/255, blue: 184/255, alpha: 1) // как в макете
    let bg = UIColor.systemBackground

    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = bg

    // Неактивные
    appearance.stackedLayoutAppearance.normal.iconColor = inactive
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: inactive]

    // Активные (использует .tint выше)
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.label
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.label]

    // Применяем
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
}
#Preview {
    MainScreen()
}

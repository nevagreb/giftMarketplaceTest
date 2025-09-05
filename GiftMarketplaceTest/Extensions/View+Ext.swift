//  Created by Kristina Grebneva on 05.09.2025.


import SwiftUI

// Attaches a tab item (title + icon) from DS for a given AppTab and tags the view
extension View {
    func tabItemView(for tab: AppTab) -> some View {
        guard let spec = DS.TabBar.items[tab] else { return AnyView(self.tag(tab)) }
        return AnyView(
            self
                .tabItem {
                    VStack {
                        Text(spec.titleKey)
                        Image(icon: spec.icon)
                    }
                }
                .tag(tab)
        )
    }
}

// Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct SearchPillButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(DS.GiftTitleBlock.searchPlaceholderText)
            } icon: {
                Image(systemName: DS.GiftTitleBlock.searcgIconName)
                    .font(.system(size: 22))
            }
            .foregroundStyle(.secondary)
            .padding(10)
            .contentShape(Rectangle())
            .frame(height: 42)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}

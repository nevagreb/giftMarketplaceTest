//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct FilterMenu: View {
    let options: [String]
    @Binding var selection: String
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Menu {
            Picker("Choose filter", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Text(selection)
                    .font(.system(size: 14))
                Image(systemName: "chevron.down")
                    .font(.system(size: 14))
                    .imageScale(.small)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(
                Capsule(style: .continuous)
                    .fill(colorScheme == .light ?
                          Color.customLightBackground : Color.customDarkBackground)
            )
        }
        .tint(.primary)
        .menuActionDismissBehavior(.automatic)
    }
}


#Preview {
    FilterMenu(options: DS.Filters.Types.options, selection: .constant("Giftbox"))
}

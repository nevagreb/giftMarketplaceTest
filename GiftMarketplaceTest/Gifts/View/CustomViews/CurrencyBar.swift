//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct CurrencyBar: View {
    @Binding var currencyCode: String
    
    var body: some View {
        Menu {
            Picker(DS.GiftToolBar.pickerName, selection: $currencyCode) {
                ForEach(DS.GiftToolBar.availableCurrencies, id: \.self) { code in
                    Text(code).tag(code)
                }
            }
        } label: {
            HStack {
                Text(currencyCode)
                Image(systemName: DS.GiftToolBar.chevronImageName)
                    .font(.body.weight(.semibold))
                    .imageScale(.small)
            }
            .contentShape(Rectangle())
        }
        .menuActionDismissBehavior(.automatic)
    }
}

#Preview {
    CurrencyBar(currencyCode: .constant(DS.GiftToolBar.defaultCurrency))
}

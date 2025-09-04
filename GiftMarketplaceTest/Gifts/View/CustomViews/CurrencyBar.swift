//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct CurrencyBar: View {
    @Binding var currencyCode: String
    
    var body: some View {
        Menu {
            Picker("Currency", selection: $currencyCode) {
                ForEach(Self.availableCurrencies, id: \.self) { code in
                    Text(code).tag(code)
                }
            }
        } label: {
            HStack {
                Text(currencyCode)
                Image(systemName: "chevron.down")
                    .font(.body.weight(.semibold))
                    .imageScale(.small)
            }
            .contentShape(Rectangle())
        }
        .menuActionDismissBehavior(.automatic)
    }
    
    private static let availableCurrencies: [String] = [
        "USD","EUR","GBP","CAD","AUD","JPY","CNY"
    ]
}

#Preview {
    CurrencyBar(currencyCode: .constant("USD"))
}

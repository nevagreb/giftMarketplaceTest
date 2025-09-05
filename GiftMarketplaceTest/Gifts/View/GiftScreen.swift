//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct GiftScreen: View {
    @State private var currency = DS.GiftToolBar.defaultCurrency
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    giftBlock
                    
                    PromoBanner(promo: PromoBannerModel.mockData, action: {})
                        .padding(.bottom, 6)
                    CategoriesRow(items: CategoryModel.mockData)
                    FilterSection(products: ProductCardModel.mockData,
                                  viewAllAction: {},
                                  onToggleFavorite: {_ in})
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .light ? Color.customLightBackground.ignoresSafeArea() : Color.customDarkBackground.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        deliveryLabel
                    }
                    .tint(.primary)
                }
            }
        }
    }
    
    private var deliveryLabel: some View {
        HStack {
            Text(DS.GiftToolBar.toolBarTitle)
            Text(DS.GiftToolBar.defaultCountyName.flagEmojiFromRegionCode)
                .font(.system(size: 42))
            CurrencyBar(currencyCode: $currency)
        }
    }
    
    private var giftBlock: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(DS.GiftTitleBlock.titleText)
                    .font(.custom(DS.Font.titleStyleFont, size: 45))
                    .foregroundStyle(.primary)
                    .textCase(.uppercase)
                Spacer()
            }

            Spacer(minLength: 12)

            VStack(spacing: 0) {
                Spacer()
                SearchPillButton(action: {})
            }
        }
    }
}

#Preview {
    NavigationStack {
        GiftScreen()
    }
}




//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct GiftScreen: View {
    @State private var currency = "USD"
    
    var body: some View {
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
        .background(Color.customBackground.ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    deliveryLabel
                }
                .tint(.primary)
            }
        }
    }
    
    private var deliveryLabel: some View {
        HStack {
            Text("Deliver to ")
            Text("US".flagEmojiFromRegionCode)
                .font(.system(size: 42))
            CurrencyBar(currencyCode: $currency)
        }
    }
    
//    private var giftBlock: some View {
//        HStack {
//            Text("GIFTS")
//                .padding(.bottom, 20)
//                .foregroundStyle(.primary)
//                .font(.custom("Impact", size: 45))
//                .textCase(.uppercase)
//            Spacer()
//            SearchPillButton(action: {})
//        }
//    }
    
    private var giftBlock: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Gifts")
                    .font(.custom("Impact", size: 45))
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




//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct FilterSection: View {
    let products: [ProductCardModel]
    let viewAllAction: () -> Void
    var onToggleFavorite: (UUID) -> Void
    
    let types: [String] = DS.Filters.Types.options
    let recipients: [String] = DS.Filters.Recipient.options
    let sorts: [String] = DS.Filters.Sort.options
    
    @State var selectedGiftbox: String = DS.Filters.Types.options[0]
    @State var selectedRecipient: String = DS.Filters.Recipient.options[0]
    @State var selectedSort: String = DS.Filters.Sort.options[0]
    
    private let columns = [
        GridItem(.flexible(), spacing: 6),
        GridItem(.flexible(), spacing: 6)
    ]
    
    var body: some View {
        VStack(spacing: 14) {
            viewAllButton
            filters
            productGrid
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(UIColor.systemBackground))
        )
    }
    
    private var viewAllButton: some View {
        Button(action: viewAllAction) {
            Text("View all categories")
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(
                    Capsule(style: .continuous)
                        .fill(Color(UIColor.systemBackground))
                        .overlay(Capsule().stroke(Color.customLightBackground, lineWidth: 1))
                )
        }
        .buttonStyle(.plain)
    }
    
    private var filters: some View {
        HStack {
            FilterMenu(options: types,
                       selection: $selectedGiftbox)
            FilterMenu(options: recipients,
                       selection: $selectedRecipient)
            FilterMenu(options: sorts,
                       selection: $selectedSort)
        }
    }
    
    private var productGrid: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(products) { product in
                ProductCard(product: product,
                            onTapHeart: { onToggleFavorite(product.id) }
                )
            }
        }
    }
}

#Preview {
    FilterSection(products: ProductCardModel.mockData,
                  viewAllAction: {},
                  onToggleFavorite: {_ in})
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.customLightBackground)
}

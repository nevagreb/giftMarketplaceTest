//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct ProductCard: View {
    let product: ProductCardModel
    var onTapHeart: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(product.imageName)
                .resizable()
                .scaledToFill()
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            Button(action: onTapHeart) {
                Image(systemName: product.isFavorite ? DS.GiftProduct.heartFillImageName : DS.GiftProduct.heartImageName)
                    .frame(width: 24, height: 24)
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.5))
                    )
            }
            .buttonStyle(.plain)
            .padding(10)
        }
    }
}

#Preview {
    ProductCard(product: ProductCardModel.mockData[0],
                onTapHeart: {})
    .frame(height: 170)
}

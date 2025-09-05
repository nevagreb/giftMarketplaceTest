//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct PromoBanner: View {
    let promo: PromoBannerModel
    let action: ()->Void
    
    var body: some View {
        ZStack {
            Color(promo.background)
            
            HStack {
                VStack(alignment: .leading, spacing: 17) {
                    Text(promo.title)
                        .font(.custom(DS.Font.titleStyleFont, size: 28))
                        .foregroundStyle(promo.fontColor)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    
                    Button(action: action) {
                        Text(promo.buttonTitle)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 5)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(87)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.leading, 17)
                .padding(.vertical, 19)
                
                Spacer()
                
                Image(promo.imageName)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    PromoBanner(promo: PromoBannerModel.mockData, action: {})
        .padding()
}

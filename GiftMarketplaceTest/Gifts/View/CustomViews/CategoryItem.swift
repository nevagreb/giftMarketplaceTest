//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct CategoryItem: View {
    let item: CategoryModel
    
    var body: some View {
        Button(action: item.action) {
            VStack(spacing: 5) {
                Image(item.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Text(item.title)
                    .font(.system(size: 12))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .buttonStyle(.plain)
        .frame(width: 100)
    }
}

#Preview {
    CategoryItem(item: CategoryModel.mockData[0])
}

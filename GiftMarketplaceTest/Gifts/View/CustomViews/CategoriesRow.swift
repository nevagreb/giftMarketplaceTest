//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct CategoriesRow: View {
    let items: [CategoryModel]
    var showAllAction: (() -> Void)?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { item in
                        CategoryItem(item: item)
                    }
                }
                
                Button(DS.GiftFilters.showAllButtonLabel) { showAllAction?() }
                    .bold()
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    CategoriesRow(items: CategoryModel.mockData)
}

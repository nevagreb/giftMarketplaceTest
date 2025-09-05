//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct ProductCardModel: Identifiable {
    let id = UUID()
    let imageName: String
    var isFavorite: Bool
    
    static let mockData: [Self] = {
        [.init(imageName: DS.GiftProduct.Image.product1.rawValue, isFavorite: false),
         .init(imageName: DS.GiftProduct.Image.product2.rawValue, isFavorite: true),
         .init(imageName: DS.GiftProduct.Image.product1.rawValue, isFavorite: false),
         .init(imageName: DS.GiftProduct.Image.product2.rawValue, isFavorite: false)]
    }()
}

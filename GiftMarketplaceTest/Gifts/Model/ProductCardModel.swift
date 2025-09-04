//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct ProductCardModel: Identifiable {
    let id = UUID()
    let imageName: String
    var isFavorite: Bool
    
    static let mockData: [Self] = {
        [.init(imageName: "product1", isFavorite: false),
        .init(imageName: "product2", isFavorite: true),
         .init(imageName: "product1", isFavorite: true),
         .init(imageName: "product2", isFavorite: true),
        ]
    }()
}

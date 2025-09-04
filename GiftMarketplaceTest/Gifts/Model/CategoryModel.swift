//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct CategoryModel: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let action: () -> Void
    
    static let mockData: [CategoryModel] = {
        [ .init(title: "New Popular Arrivals", imageName: "catNew", action: {}),
          .init(title: "Mixed Flowers", imageName: "catMixed", action: {}),
          .init(title: "Thank you", imageName: "catThanks", action: {}),
            .init(title: "New Popular Arrivals", imageName: "catNew", action: {}),
            .init(title: "Mixed Flowers", imageName: "catMixed", action: {}),
            .init(title: "Thank you", imageName: "catThanks", action: {})]
    }()
}

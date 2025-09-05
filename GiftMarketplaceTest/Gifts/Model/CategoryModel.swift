//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct CategoryModel: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let action: () -> Void
    
    static let mockData: [CategoryModel] = {
        [ .init(title: DS.GiftCategory.Title.new.rawValue, imageName: DS.GiftCategory.Image.new.rawValue, action: {}),
          .init(title: DS.GiftCategory.Title.mixed.rawValue, imageName: DS.GiftCategory.Image.mixed.rawValue, action: {}),
          .init(title: DS.GiftCategory.Title.thank.rawValue, imageName: DS.GiftCategory.Image.thank.rawValue, action: {}),
          .init(title: DS.GiftCategory.Title.new.rawValue, imageName: DS.GiftCategory.Image.new.rawValue, action: {}),
          .init(title: DS.GiftCategory.Title.mixed.rawValue, imageName: DS.GiftCategory.Image.mixed.rawValue, action: {}),
          .init(title: DS.GiftCategory.Title.thank.rawValue, imageName: DS.GiftCategory.Image.thank.rawValue, action: {})]
    }()
}

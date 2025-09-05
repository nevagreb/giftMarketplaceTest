//  Created by Kristina Grebneva on 04.09.2025.


import SwiftUI

struct PromoBannerModel: Identifiable {
    let id = UUID()
    let title: String
    let buttonTitle: String
    let background: Color
    let fontColor: Color
    let imageName: String
    
    static let mockData = PromoBannerModel(
        title: DS.GiftBanner.title,
        buttonTitle: DS.GiftBanner.buttonTitle,
        background: .bannerBackground,
        fontColor: .bannerFontColor,
        imageName: DS.GiftBanner.imageName
    )
}

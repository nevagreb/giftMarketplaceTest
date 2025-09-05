//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

extension Color {
    static let customLightBackground = Color(hex: "#EFF3FF")
    static let customDarkBackground = Color(hex: "#757E9A")
    static let bannerBackground = Color(hex: "#BA4347")
    static let bannerFontColor = Color(hex: "#FFBCBD")
    static let darkGrey = Color(hex: "#757E9A")
    static let lightCircleBlue = Color(hex: "#D0D8EF")
    static let darkCircleBlue = Color(hex: "#555D74")

    init(hex: String, alpha: Double = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

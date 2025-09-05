//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

// Converts a 2-letter region code (e.g., "US") to its flag emoji
extension String {
    var flagEmojiFromRegionCode: String {
        let base = "🇦".unicodeScalars.first!.value - "A".unicodeScalars.first!.value
        return self.uppercased().unicodeScalars
            .compactMap { UnicodeScalar(base + $0.value) }
            .map { String($0) }
            .joined()
    }
}

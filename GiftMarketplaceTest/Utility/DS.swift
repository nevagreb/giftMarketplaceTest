//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct DS {
    struct Filters {
        enum Types {
            static let options: [String] = [
                "Giftboxes",
                "Flowers",
                "Candles",
                "Sweets",
                "Perfumes",
                "Jewelry",
                "Home Decor",
                "Books"
            ]
        }
        
        enum Recipient {
            static let options: [String] = [
                "For her",
                "For him",
                "For kids",
                "For parents",
                "For friends",
                "For colleagues"
            ]
        }
        
        enum Sort {
            static let options: [String] = [
                "Popular",
                "New",
                "Price: Low to High",
                "Price: High to Low",
                "Best Rated",
                "On Sale"
            ]
        }
    }
}

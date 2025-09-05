//  Created by Kristina Grebneva on 04.09.2025.


import Foundation

struct DS {
    struct GiftTitleBlock {
        static let searchPlaceholderText = "Search"
        static let searcgIconName = "magnifyingglass"
        static let titleText = "Gifts"
    }
    
    struct GiftFilters {
        static let showAllButtonLabel = "ShowAll"
        static let viewAllButtonLabel = "View all categories"
        static let pickerName = "Choose filter"
        static let chevronImageName = "chevron.down"
        
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
    
    struct GiftCategory {
        enum Title: String {
            case new = "New Popular Arrivals"
            case mixed = "Mixed Flowers"
            case thank = "Thank you"
        }
        
        enum Image: String {
            case new = "catNew"
            case mixed = "catMixed"
            case thank = "catThanks"
        }
    }
    
    struct GiftProduct {
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        
        enum Image: String {
            case product1 = "product1"
            case product2 = "product2"
        }
    }
    
    struct GiftBanner {
        static let title = "UPCOMING\nHOLIDAYS SOON"
        static let buttonTitle = "Call to action"
        static let imageName = "bouquet"
    }
    
    struct GiftToolBar {
        static let toolBarTitle: String = "Deliver to "
        static let defaultCountyName = "US"
        static let pickerName = "Currency"
        static let defaultCurrency: String = "USD"
        static let availableCurrencies: [String] = [
            "USD","EUR","GBP","CAD","AUD","JPY","CNY"
        ]
        static let chevronImageName = "chevron.down"
    }
    
    struct Font {
        static let titleStyleFont = "Impact"
    }
    
    struct TabBar {
        struct Item {
            let titleKey: String
            let icon: Icon
        }
        
        enum Icon {
            case asset(String)
            case system(String)
        }
        
        static let items: [AppTab: Item] = [
            .gifts:   .init(titleKey: "Gifts",   icon: .asset("gift")),
            .flowers: .init(titleKey: "Flowers", icon: .asset("tulip")),
            .events:  .init(titleKey: "Events",  icon: .asset("events")),
            .cart:    .init(titleKey: "Cart",    icon: .asset("cart")),
            .profile: .init(titleKey: "Profile", icon: .asset("profile"))
        ]
        
        static func title(for tab: AppTab) -> String {
            String(items[tab]!.titleKey)
        }
    }
    
    struct SignIn {
        static let appleLogo = "apple"
        static let googleLogo = "glogo"
        static let appleButtonTitle = "Continue with Apple"
        static let googleButtonTitle = "Continue with Google"
        static let skipButtonTitle = "Skip"
        static let alertTitle = "Sign-in error"
        static let alertOkButtonTitle = "OK"
        static let welcomeTitle = "Welcome"
        static let welcomeSubtitle = "Enter your phone number. We will send you an SMS with a confirmation code to this number."
        static let termsDescription = "By continuing, you agree to Assetsy’s "
        static let terms = "Terms of Use"
        static let and: String = " and "
        static let privacy: String = "Privacy Policy"
        static let backgroundFlowerImage = "flower"
        static let backgroundCircleImage = "circle"

    }
}

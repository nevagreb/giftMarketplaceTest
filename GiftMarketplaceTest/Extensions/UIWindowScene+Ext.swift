//  Created by Kristina Grebneva on 05.09.2025.


import UIKit

// Retrieves the key window for a given scene, needed for google authorization
extension UIWindowScene {
    var keyWindow: UIWindow? { windows.first { $0.isKeyWindow } }
}

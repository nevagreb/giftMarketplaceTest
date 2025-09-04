//  Created by Kristina Grebneva on 05.09.2025.


import UIKit

extension UIWindowScene {
    var keyWindow: UIWindow? { windows.first { $0.isKeyWindow } }
}

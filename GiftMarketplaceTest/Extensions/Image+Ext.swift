//  Created by Kristina Grebneva on 05.09.2025.


import SwiftUI

// Creates an Image from DS.TabBar.Icon (asset or SF Symbol)
extension Image {
    init(icon: DS.TabBar.Icon) {
        switch icon {
        case .asset(let name):  self = Image(name)
        case .system(let name): self = Image(systemName: name)
        }
    }
}

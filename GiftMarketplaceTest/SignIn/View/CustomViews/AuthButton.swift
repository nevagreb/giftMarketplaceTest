//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct AuthButton: View {
    enum Kind { case apple, google }

    let kind: Kind
    let action: () -> Void

    var body: some View {
            Button(action: action) {
                HStack(spacing: 8) {
                    Image(kind == .apple ? "apple" : "glogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text(kind == .apple ? "Continue with Apple" : "Continue with Google")
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.85)
                }
                .foregroundStyle(Color.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
    }
}

//#Preview {
//    AuthButton(with: .apple, action: {})
//}

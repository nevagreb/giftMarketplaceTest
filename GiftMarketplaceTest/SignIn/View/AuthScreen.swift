//  Created by Kristina Grebneva on 04.09.2025.

import SwiftUI

struct AuthScreen: View {
    var body: some View {
        VStack{
            welcomeBlock
            Spacer()
            authButtons
            terms
        }
        .padding()
        .background(background)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Skip") {}
                    .tint(.primary)
            }
        }
    }
    
    private var welcomeBlock: some View {
        VStack(alignment: .leading) {
            Text("Welcome")
                .padding(.bottom, 20)
                .foregroundStyle(.primary)
                .font(.custom("Impact", size: 45))
                .textCase(.uppercase)
            Text("Enter your phone number. We will send you an SMS with a confirmation code to this number.")
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var authButtons: some View {
        VStack(spacing: 8) {
            AuthButton(kind: .apple, action: {})
            AuthButton(kind: .google, action: {})
        }
        .padding(.bottom, 16)
    }
    
    private var terms: some View {
        VStack(alignment: .center) {
            Text("By continuing, you agree to Assetsy’s ")
            
            Text("Terms of Use")
                .foregroundStyle(.blue)
                .underline(true, color: .blue)
            + Text(" and ")
            + Text("Privacy Policy")
                .foregroundStyle(.blue)
                .underline(true, color: .blue)
        }
        .foregroundStyle(.primary)
    }
    
    private var background: some View {
        ZStack {
            Color.customBackground
            Image("circle")
            Image("flower")
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        AuthScreen()
    }
}


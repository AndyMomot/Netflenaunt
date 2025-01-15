//
//  ProfileButton.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import SwiftUI

struct ProfileButton: View {
    let title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 26) {
                Asset.redCircle.swiftUIImage
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 14))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 14)
            .padding(.horizontal)
            .background(LinearGradientBackground())
            .cornerRadius(4, corners: .allCorners)
            .shadowModifier()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        ProfileButton(title: "Manage categories") {}
            .padding()
    }
}

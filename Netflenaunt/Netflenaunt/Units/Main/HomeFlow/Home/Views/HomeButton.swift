//
//  HomeButton.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import SwiftUI

struct HomeButton: View {
    var image: String
    var title: String
    var color: Color
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                color
                    .cornerRadius(4, corners: .allCorners)
                    .shadow(color: .ashGray.opacity(0.25),
                            radius: 4,
                            x: -4, y: -4)
                    .shadow(color: .black.opacity(0.25),
                            radius: 4,
                            x: 4, y: 4)
                
                VStack(spacing: 4) {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28)
                    
                    Text(title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                        .multilineTextAlignment(.center)
                }
                .padding(12)
            }
        }
    }
}

#Preview {
    HomeButton(image: Asset.addCost.name,
               title: "Dodaj wydatek",
               color: .redCustom) {}
}

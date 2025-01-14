//
//  HomeCostsView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import SwiftUI

struct HomeCostsView: View {
    var name: String
    var costs: Double
    var image: String
    
    var body: some View {
        Asset.costsBg.swiftUIImage
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(180))
            .shadow(color: .ashGray.opacity(0.25),
                    radius: 4,
                    x: -4, y: -4)
            .shadow(color: .black.opacity(0.25),
                    radius: 4,
                    x: 4, y: 4)
            .overlay {
                VStack(spacing: 10) {
                    Text(name)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    
                    Text(costs.string())
                        .foregroundStyle(.redCustom)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .opacity(0.3)
                }
            }
    }
}

#Preview {
    HomeCostsView(name: "Biznes",
                  costs: 1010.22,
                  image: Asset.bussinessCost.name)
        .padding()
}

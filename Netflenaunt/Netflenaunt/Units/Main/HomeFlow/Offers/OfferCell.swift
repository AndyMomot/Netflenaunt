//
//  OfferCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import SwiftUI

struct OfferCell: View {
    let item: OffersView.OfferItem
    
    var body: some View {
        HStack {
            Text(item.title)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text(item.text)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.4)
        }
        .foregroundStyle(.white)
        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        OfferCell(item: .init(title: "Śledzenie trendów:",
                              text: "Przeanalizuj, które koszty rosną, aby określić, czy można je zmniejszyć."))
        .padding()
    }
}

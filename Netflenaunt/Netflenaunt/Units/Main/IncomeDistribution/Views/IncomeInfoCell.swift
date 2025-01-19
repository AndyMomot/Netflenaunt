//
//  IncomeInfoCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 19.01.2025.
//

import SwiftUI

struct IncomeInfoCell: View {
    var imageName: String
    var title: String
    var amount: Int
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .padding(8)
                    .background(LinearGradientBackground())
                    .clipShape(Circle())
                    .shadowModifier()
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
            }
            
            Spacer()
            
            Text("\(amount)")
                .foregroundStyle(.redCustom)
                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 24))
                .multilineTextAlignment(.center)
                .padding(.vertical, 26)
                .padding(.horizontal, 13)
                .background(LinearGradientBackground())
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadowModifier()
            
        }
        .padding()
        .background(LinearGradientBackground())
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        IncomeInfoCell(
            imageName: Asset.bussinessCost.name,
            title: "Income text",
            amount: 1245
        )
        .padding()
    }
}

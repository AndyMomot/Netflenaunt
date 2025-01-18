//
//  CostStatisticsCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct CostStatisticsCell: View {
    let item: TransactionModel
    
    var body: some View {
        HStack(spacing: 15) {
            Asset.addCost.swiftUIImage
                .renderingMode(.template)
                .foregroundStyle(.redCustom)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(item.category.name):")
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                HStack {
                    Text("\(item.amount)")
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                    
                    Spacer()
                    
                    Text(item.date.toString(format: .ddMMyyyy))
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 10))
                }
            }
            .foregroundStyle(.white)
        }
        .padding()
        .background(LinearGradientBackground())
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        CostStatisticsCell(
            item: .init(
                type: .income,
                origin: .business,
                amount: 300,
                category: .init(name: "Rent"),
                date: .init(),
                comment: ""))
    }
}

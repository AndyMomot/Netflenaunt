//
//  ReportCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct ReportCell: View {
    let section: ReportView.TransactionSection
    
    var body: some View {
        HStack(spacing: 10) {
            Text(section.title)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                ForEach(section.items) { item in
                    Text("\(item.category.name): \(item.amount)")
                }
                .multilineTextAlignment(.trailing)
            }
        }
        .foregroundStyle(.white)
        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        ReportCell(section: .init(
            title: "12/12/2024",
            items: [
                .init(type: .income,
                      origin: .business,
                      amount: 300,
                      category: .init(name: "Rent"),
                      date: .init(),
                      comment: ""),
                
                    .init(type: .cost,
                          origin: .personal,
                          amount: 125,
                          category: .init(name: "Food"),
                          date: .init(),
                          comment: ""),
            ]
        ))
        .padding()
    }
}

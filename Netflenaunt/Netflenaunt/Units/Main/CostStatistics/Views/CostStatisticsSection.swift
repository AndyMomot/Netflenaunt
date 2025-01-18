//
//  CostStatisticsSection.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct CostStatisticsSection: View {
    let section: ReportView.TransactionSection
    
    var body: some View {
        VStack(spacing: 10) {
            Text(section.title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                .multilineTextAlignment(.center)
            
            ForEach(section.items) { item in
                CostStatisticsCell(item: item)
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        CostStatisticsSection(section: .init(
            title: "11/12/2024",
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

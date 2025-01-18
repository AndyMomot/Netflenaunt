//
//  CostStatisticsChart.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI
import Charts

struct CostStatisticsChart: View {
    let barItems: [CostStatisticsView.BarItem]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(barItems) { item in
                    BarMark(
                        x: .value("1", item.category.name),
                        y: .value("2", item.amount)
                    )
                    .foregroundStyle(.redCustom)
                    .cornerRadius(30)
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel {
                        Text("\(value.as(String.self) ?? "")")
                            .foregroundColor(.white)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 10))
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisValueLabel {
                        Text("\(value.as(Int.self) ?? 0)")
                            .foregroundColor(.white)
                            .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 10))
                    }
                }
            }
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
        CostStatisticsChart(barItems: [
            .init(category: .init(name: "First"), amount: 300),
            .init(category: .init(name: "Second"), amount: 250),
            .init(category: .init(name: "Third"), amount: 350),
        ])
        .padding()
    }
}

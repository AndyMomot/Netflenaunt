//
//  CostStatisticsFilter.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct CostStatisticsFilter: View {
    @Binding var selectedOrigen: String
    let categories: [String]
    @Binding var selectedCategory: String
    @Binding var fromDate: Date
    @Binding var toDate: Date
    
    @State private var origenItems = TransactionModel.TransactionOrigin.allCases.map { $0.rawValue }
    
    var body: some View {
        VStack(spacing: 15) {
            MenuPicker(
                title: "Rodzaj wydatku",
                items: origenItems,
                selection: $selectedOrigen
            )
            
            MenuPicker(
                title: "Kategoria",
                items: categories,
                selection: $selectedCategory
            )
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Okres")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                HStack {
                    DatePicker("", selection: $fromDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    .colorScheme(.dark)
                    .accentColor(.redCustom)
                    
                    Text("-")
                        .foregroundStyle(.white)
                    
                    DatePicker("", selection: $toDate,
                               displayedComponents: .date)
                    .labelsHidden()
                    .colorScheme(.dark)
                    .accentColor(.redCustom)
                    
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 28)
                .background(LinearGradientBackground())
                .cornerRadius(8, corners: .allCorners)
                .shadowModifier()
            }
        }
        .onAppear {
            origenItems.append("")
        }
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        
        CostStatisticsFilter(
            selectedOrigen: .constant(""),
            categories: ["First", "Second", "Third"],
            selectedCategory: .constant(""),
            fromDate: .constant(.init()),
            toDate: .constant(.init()))
            .padding()
    }
}

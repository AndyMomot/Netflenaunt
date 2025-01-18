//
//  ReportView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct ReportView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                BackButton(title: "Tworzenie raportu")
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        // Date Piker
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Okres")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            
                            HStack {
                                DatePicker("", selection: $viewModel.fromDate,
                                           displayedComponents: .date)
                                    .labelsHidden()
                                    .colorScheme(.dark)
                                    .accentColor(.redCustom)
                                
                                Text("-")
                                    .foregroundStyle(.white)
                                
                                DatePicker("", selection: $viewModel.toDate,
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
                        
                        // Raport
                        Text("Raport")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        
                        // Sections
                        
                        // Percentage
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.reportSections) { section in
                                ReportCell(section: section)
                            }
                            
                            HStack(spacing: 10) {
                                Text("Średni stosunek wydatków osobistych i służbowych")
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Wydatki osobiste: \(viewModel.personalCosts)%")
                                    Text("Wydatki służbowe: \(viewModel.businessCosts)%")
                                }
                                .multilineTextAlignment(.trailing)
                            }
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                        }
                        .padding()
                        .background(LinearGradientBackground())
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .shadowModifier()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getReport()
        }
        .onChange(of: viewModel.fromDate) { newValue in
            if newValue >= viewModel.toDate {
                viewModel.toDate = newValue.addOrSubtract(component: .day, value: 1)
            }
            
            withAnimation {
                viewModel.getReport()
            }
        }
        .onChange(of: viewModel.toDate) { _ in
            withAnimation {
                viewModel.getReport()
            }
        }
    }
}

#Preview {
    ReportView()
}

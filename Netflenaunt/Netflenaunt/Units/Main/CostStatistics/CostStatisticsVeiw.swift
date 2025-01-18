//
//  CostStatisticsView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import SwiftUI

struct CostStatisticsView: View {
    @EnvironmentObject private var tabBarViewModel: TabBar.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradientBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    NavigationBarView { action in
                        switch action {
                        case .onProfile:
                            let selection = TabBar.TabBarSelectionView.profile.rawValue
                            DispatchQueue.main.async {
                                withAnimation {
                                    tabBarViewModel.selection = selection
                                }
                            }
                        case .onOffers:
                            viewModel.showOffers.toggle()
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Przeglądanie wydatków")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                .multilineTextAlignment(.center)
                            
                            CostStatisticsChart(barItems: viewModel.barItems)
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            if viewModel.showFilter {
                                                viewModel.getCostItems()
                                            }
                                            viewModel.showFilter.toggle()
                                        }
                                    } label: {
                                        Asset.filter.swiftUIImage
                                    }
                                }
                                
                                if viewModel.showFilter {
                                    CostStatisticsFilter(
                                        selectedOrigen: $viewModel.origen,
                                        categories: viewModel.categories,
                                        selectedCategory: $viewModel.category,
                                        fromDate: $viewModel.fromDate,
                                        toDate: $viewModel.toDate
                                    )
                                } else {
                                    if viewModel.reportSections.isEmpty {
                                        Text("Nie znaleziono żadnych rekordów.")
                                            .foregroundStyle(.white)
                                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                            .multilineTextAlignment(.center)
                                    } else {
                                        ForEach(viewModel.reportSections) { section in
                                            CostStatisticsSection(section: section)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.never)
                }
                .padding()
            }
            .onAppear {
                viewModel.createBarItems()
                viewModel.getCostItems()
                viewModel.getCategories()
            }
            .navigationDestination(isPresented: $viewModel.showOffers) {
                OffersView()
            }
            .onChange(of: viewModel.fromDate) { newValue in
                if newValue >= viewModel.toDate {
                    viewModel.toDate = newValue.addOrSubtract(component: .day, value: 1)
                }
            }
        }
    }
}

#Preview {
    CostStatisticsView()
}

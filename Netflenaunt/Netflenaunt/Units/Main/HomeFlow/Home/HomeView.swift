//
//  HomeView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import SwiftUI

struct HomeView: View {
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
                            Asset.costsBg.swiftUIImage
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .overlay {
                                    VStack(spacing: 18) {
                                        VStack(spacing: 8) {
                                            Text("Koszty ogólne")
                                                .foregroundStyle(.white)
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                                            
                                            Text("\(viewModel.totalCosts)")
                                                .foregroundStyle(.redCustom)
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                            
                                            HStack(spacing: 10) {
                                                HomeCostsView(
                                                    name: "Biznes",
                                                    costs: viewModel.businessCosts,
                                                    image: Asset.bussinessCost.name
                                                )
                                                
                                                HomeCostsView(
                                                    name: "Osobisty",
                                                    costs: viewModel.personalCosts,
                                                    image: Asset.personalCosts.name
                                                )
                                            }
                                        }
                                    }
                                    .padding(30)
                                }
                            
                            VStack(spacing: 15) {
                                HStack(spacing: 15) {
                                    HomeButton(
                                        image: Asset.addCost.name,
                                        title: "Dodaj wydatek",
                                        color: .redCustom) {
                                            viewModel.showAddCost.toggle()
                                        }
                                    
                                    HomeButton(
                                        image: Asset.addIncome.name,
                                        title: "Dodaj dochód",
                                        color: .graphite) {
                                            viewModel.showAddIncome.toggle()
                                        }
                                }
                                
                                HomeButton(
                                    image: Asset.report.name,
                                    title: "Dodaj dochód",
                                    color: .black) {
                                        viewModel.showReport.toggle()
                                    }
                            }
                            .padding(.vertical, 25)
                            .padding(.horizontal)
                            .background(LinearGradientBackground())
                            .shadowModifier()
                        }
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.getReport()
            }
            .navigationDestination(isPresented: $viewModel.showOffers) {
                OffersView()
            }
            .navigationDestination(isPresented: $viewModel.showAddIncome) {
                AddTransactionView(viewType: .income)
            }
            .navigationDestination(isPresented: $viewModel.showAddCost) {
                AddTransactionView(viewType: .cost)
            }
            .navigationDestination(isPresented: $viewModel.showReport) {
                ReportView()
            }
        }
    }
}

#Preview {
    HomeView()
}

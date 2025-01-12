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
                                        
                                        Text(viewModel.totalCosts.string())
                                            .foregroundStyle(.redCustom)
                                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                        
                                        HStack(spacing: 10) {
                                            HomeCostsView(
                                                name: "Biznes",
                                                costs: viewModel.bussinesCosts,
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
                                        
                                    }
                                
                                HomeButton(
                                    image: Asset.addIncome.name,
                                    title: "Dodaj dochód",
                                    color: .graphite) {
                                        
                                    }
                            }
                            
                            HomeButton(
                                image: Asset.report.name,
                                title: "Zobacz raport",
                                color: .black) {
                                    
                                }
                        }
                        .padding(.vertical, 25)
                        .padding(.horizontal)
                        .background(
                            LinearGradientBackground()
                        )
                        .shadow(color: .ashGray.opacity(0.25),
                                radius: 4,
                                x: -4, y: -4)
                        .shadow(color: .black.opacity(0.25),
                                radius: 4,
                                x: 4, y: 4)
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}

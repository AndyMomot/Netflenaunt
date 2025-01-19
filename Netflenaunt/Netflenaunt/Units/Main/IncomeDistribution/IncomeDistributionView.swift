//
//  IncomeDistributionView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 19.01.2025.
//

import SwiftUI

struct IncomeDistributionView: View {
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
                            Text("Podział dochodu")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                .multilineTextAlignment(.center)
                            
                            CustomTextField(
                                title: "Procent dochodu, który chcesz odłożyć na własne potrzeby:",
                                placeholder: "00",
                                text: $viewModel.neededIncomePercentage
                            )
                            .keyboardType(.numberPad)
                            .padding(.top, 5)
                            .onChange(of: viewModel.neededIncomePercentage) { newValue in
                                viewModel.updatePercentage(newValue: newValue)
                            }
                            
                            IncomeInfoCell(
                                imageName: Asset.bussinessCost.name,
                                title: "Dochód z działalności gospodarczej",
                                amount: viewModel.businessIncome
                            )
                            
                            IncomeInfoCell(
                                imageName: Asset.personalCosts.name,
                                title: "Dochód osobisty",
                                amount: viewModel.personalIncome
                            )
                            
                            VStack(spacing: 15) {
                                Text("Wskazówki dotyczące optymalnej dystrybucji")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                    .multilineTextAlignment(.center)
                                
                                ForEach(viewModel.offerItems) { item in
                                    OfferCell(item: item)
                                }
                            }
                            .padding(.vertical, 24)
                            .padding(.horizontal)
                            .background(LinearGradientBackground())
                            .cornerRadius(4, corners: .allCorners)
                            .shadowModifier()
                        }
                    }
                    .scrollIndicators(.never)
                }
                .padding()
            }
            .onAppear {
                viewModel.getNeededIncomePercentage()
                viewModel.getReport()
            }
            .hideKeyboardWhenTappedAround()
            .navigationDestination(isPresented: $viewModel.showOffers) {
                OffersView()
            }
        }
    }
}

#Preview {
    IncomeDistributionView()
}

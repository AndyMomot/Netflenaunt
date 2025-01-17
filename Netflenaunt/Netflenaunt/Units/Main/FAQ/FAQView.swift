//
//  FAQView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import SwiftUI

struct FAQView: View {
    @EnvironmentObject private var tabBarViewModel: TabBar.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradientBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
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
                        VStack(spacing: 15) {
                            ForEach(viewModel.faqItems) { item in
                                FAQCell(item: item)
                            }
                        }
                        .padding()
                        .background(LinearGradientBackground())
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .shadowModifier()
                    }
                    .scrollIndicators(.never)
                }
                .padding()
            }
            .navigationDestination(isPresented: $viewModel.showOffers) {
                OffersView()
            }
        }
    }
}

#Preview {
    FAQView()
}

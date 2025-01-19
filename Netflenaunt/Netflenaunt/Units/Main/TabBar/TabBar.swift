//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                TabView(selection: $viewModel.selection) {
                    HomeView()
                        .tag(TabBarSelectionView.home.rawValue)
                        .environmentObject(viewModel)
                    
                    CostStatisticsView()
                        .tag(TabBarSelectionView.statistics.rawValue)
                        .environmentObject(viewModel)
                    
                    IncomeDistributionView()
                        .tag(TabBarSelectionView.finance.rawValue)
                        .environmentObject(viewModel)
                    
                    ProfileView()
                        .tag(TabBarSelectionView.profile.rawValue)
                    
                    FAQView()
                        .tag(TabBarSelectionView.faq.rawValue)
                        .environmentObject(viewModel)
                }
                
                if viewModel.isShowTabBar {
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}

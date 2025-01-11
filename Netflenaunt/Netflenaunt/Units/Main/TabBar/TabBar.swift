//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                TabView(selection: $viewModel.selection) {
                    Text("Tab 1")
                        .tag(TabBarSelectionView.home.rawValue)
                    
                    Text("Tab 2")
                        .tag(TabBarSelectionView.statistics.rawValue)
                    
                    Text("Tab 3")
                        .tag(TabBarSelectionView.profile.rawValue)
                    
                    Text("Tab 4")
                        .tag(TabBarSelectionView.finance.rawValue)
                    
                    Text("Tab 5")
                        .tag(TabBarSelectionView.faq.rawValue)
                }
                
                Spacer()
                
                if viewModel.isShowTabBar {
                    TabBarCustomView(selectedItem: $viewModel.selection)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}

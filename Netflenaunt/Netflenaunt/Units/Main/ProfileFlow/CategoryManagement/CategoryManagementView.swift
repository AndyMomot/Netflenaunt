//
//  CategoryManagementView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import SwiftUI

struct CategoryManagementView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                BackButton(title: "Zarządzaj kategoriami")
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.categories) { item in
                            CategoryCell(item: item) { action in
                                viewModel.handleCategoryCell(action: action)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                NextButton(title: "Dodaj kategorię") {
                    viewModel.showAddCategory.toggle()
                }
            }
            .padding()
            .hideKeyboardWhenTappedAround()
            
            if viewModel.showAddCategory {
                AddCategoryView { action in
                    viewModel.handleCategoryView(action: action)
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
    }
}

#Preview {
    CategoryManagementView()
}

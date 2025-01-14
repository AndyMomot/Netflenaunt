//
//  AddTransactionView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import SwiftUI

struct AddTransactionView: View {
    let viewType: TransactionModel.TransactionType
    @StateObject private var viewModel = ViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 28) {
                BackButton(title: viewType.rawValue)
                
                ScrollView {
                    VStack(spacing: 15) {
                        MenuPicker(
                            title: "Rodzaj wydatku",
                            items: TransactionModel.TransactionOrigin.allCases.map { $0.rawValue },
                            selection: $viewModel.selectedTransactionType
                        )
                        
                        CustomTextField(
                            title: "Suma",
                            placeholder: "00",
                            text: $viewModel.amount
                        )
                        .keyboardType(.numberPad)
                        
                        MenuPicker(
                            title: "Kategoria",
                            items: viewModel.categories.map { $0.name },
                            showAddButton: true,
                            selection: $viewModel.selectedCategory
                        ) { // on plus
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.showAddCategory.toggle()
                            }
                        }
                        
                        DatePickerView(
                            title: "Data",
                            selection: $viewModel.date
                        )
                        
                        CustomTextField(
                            title: "Komentarz",
                            placeholder: "Wpisz komentarz...",
                            text: $viewModel.comment
                        )
                    }
                }
                .scrollIndicators(.never)
                
                NextButton(title: "Dodaj wydatek") {
                    viewModel.saveTransaction(type: viewType) {
                        dismiss.callAsFunction()
                    }
                }
                .ignoresSafeArea(.keyboard)
                .disabled(!viewModel.canSave)
                .opacity(viewModel.canSave ? 1 : 0.5)
            }
            .padding()
            
            if viewModel.showAddCategory {
                AddCategoryView { action in
                    viewModel.handleCategoryView(action: action)
                }
                .ignoresSafeArea()
            }
        }
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.getCategories()
        }
        .onChange(of: viewModel.selectedTransactionType) { _ in
            viewModel.validate()
        }
        .onChange(of: viewModel.amount) { _ in
            viewModel.validate()
        }
        .onChange(of: viewModel.selectedCategory) { _ in
            viewModel.validate()
        }
        .onChange(of: viewModel.comment) { _ in
            viewModel.validate()
        }
    }
}

#Preview {
    AddTransactionView(viewType: .income)
}

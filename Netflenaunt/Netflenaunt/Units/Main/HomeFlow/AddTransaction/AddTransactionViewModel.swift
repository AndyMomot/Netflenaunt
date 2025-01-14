//
//  AddTransactionViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import Foundation

extension AddTransactionView {
    final class ViewModel: ObservableObject {
        @Published var selectedTransactionType = ""
        @Published var amount = ""
        @Published var categories: [TransactionCategory] = []
        @Published var selectedCategory = ""
        @Published var date = Date()
        @Published var comment = ""
        
        @Published var showAddCategory = false
        @Published var canSave = false
    }
}

extension AddTransactionView.ViewModel {
    func getCategories() {
        Task { [weak self] in
            guard let self else { return }
            let categories = DefaultsService.shared.categories
            
            await MainActor.run {
                self.categories = categories
            }
        }
    }
    
    func handleCategoryView(action: AddCategoryView.ViewAction) {
        switch action {
        case .dismiss:
            Task { [weak self] in
                guard let self else { return }
                await MainActor.run {
                    self.showAddCategory.toggle()
                }
            }
        case .add(let category):
            Task { [weak self] in
                guard let self else { return }
                await MainActor.run {
                    self.showAddCategory.toggle()
                }
            }
            
            saveCategory(name: category)
        }
    }
    
    func validate() {
        Task { [weak self] in
            guard let self else { return }
            let isValid = !selectedTransactionType.isEmpty
            && Int(amount) ?? .zero > .zero
            && !selectedCategory.isEmpty
            && !comment.isEmpty
            
            await MainActor.run {
                self.canSave = isValid
            }
        }
    }
    
    func saveTransaction(type: TransactionModel.TransactionType, completion: @escaping () -> Void) {
        Task { [weak self] in
            guard let self else { return }
            
            guard let origin = TransactionModel.TransactionOrigin(rawValue: self.selectedTransactionType),
                  let category = categories.first(where: {$0.name == self.selectedCategory})
            else { return }
            
            let item = TransactionModel(
                type: type,
                origin: origin,
                amount: Int(self.amount) ?? .zero,
                category: category,
                date: self.date,
                comment: self.comment
            )
            
            DefaultsService.shared.transactions.append(item)
            
            await MainActor.run {
                completion()
            }
        }
    }
}

private extension AddTransactionView.ViewModel {
    func saveCategory(name: String) {
        Task { [weak self] in
            guard let self else { return }
            let shared = DefaultsService.shared
            
            if !shared.categories.contains(where: { $0.name == name}) {
                let item = TransactionCategory(name: name)
                shared.categories.append(item)
                self.getCategories()
            }
        }
    }
}

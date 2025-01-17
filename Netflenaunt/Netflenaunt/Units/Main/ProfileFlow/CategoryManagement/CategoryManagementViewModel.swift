//
//  CategoryManagementViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import Foundation

extension CategoryManagementView {
    final class ViewModel: ObservableObject {
        @Published var categories: [TransactionCategory] = []
        @Published var showAddCategory = false
    }
}

extension CategoryManagementView.ViewModel {
    func getCategories() {
        Task { [weak self] in
            guard let self else { return }
            let categories = DefaultsService.shared.categories.sorted(by: {$0.name < $1.name})
            await MainActor.run {
                self.categories = categories
            }
        }
    }
    
    func handleCategoryCell(action: CategoryCell.ViewAction) {
        switch action {
        case .delete(let id):
            Task { [weak self] in
                guard let self else { return }
                DefaultsService.shared.categories.removeAll(where: { $0.id == id })
                self.getCategories()
            }
        case .updateLimit(let id, let value):
            Task { [weak self] in
                let shared = DefaultsService.shared
                guard let self, let index = shared.categories.firstIndex(where: { $0.id == id })
                else { return }
                DefaultsService.shared.categories[index].limit = value
                self.getCategories()
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
}

private extension CategoryManagementView.ViewModel {
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

//
//  CostStatisticsViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import Foundation

extension CostStatisticsView {
    final class ViewModel: ObservableObject {
        @Published var showOffers = false
        @Published var barItems = [CostStatisticsView.BarItem]()
        
        @Published var showFilter = false
        @Published var reportSections = [ReportView.TransactionSection]()
        
        @Published var fromDate = Date().addOrSubtract(component: .month, value: -1)
        @Published var toDate = Date()
        
        @Published var origen = ""
        @Published var categories = [String]()
        @Published var category = ""
    }
}

extension CostStatisticsView.ViewModel {
    func createBarItems() {
        Task { [weak self] in
            guard let self else { return }
            let shared = DefaultsService.shared
            
            // Обчислення в фоновому потоці
            let barItems = shared.categories.map { category in
                let totalAmount = shared.transactions.filter {
                    $0.category.name == category.name && $0.type == .cost
                }.map { $0.amount }.reduce(0, +)
                return CostStatisticsView.BarItem(category: category, amount: totalAmount)
            }
            
            // Оновлення на головному потоці
            await MainActor.run {
                self.barItems = barItems
            }
        }
    }
    
    func getCostItems() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            var transactions = DefaultsService.shared.transactions.filter {
                $0.date >= self.fromDate && $0.date <= self.toDate
            }.sorted(by: { $0.date > $1.date })
            
            if !self.origen.isEmpty {
                transactions = transactions.filter { $0.origin.rawValue == self.origen }
            }
            
            if !self.category.isEmpty {
                transactions = transactions.filter { $0.category.name == self.category }
            }
            
            let groupedItems = transactions.reduce(into: [Date: [TransactionModel]]()) { result, item in
                let date = item.date.format(to: .ddMMyyyy) ?? item.date
                if result[date] != nil {
                    result[date]?.append(item)
                    result[date]?.sort(by: {$0.date > $1.date})
                } else {
                    result[date] = [item]
                }
            }.sorted(by: {$0.key > $1.key})
            
            let sections: [ReportView.TransactionSection] = groupedItems.map {
                let dateString = $0.key.toString(format: .ddMMyyyy)
                return .init(title: dateString, items: $0.value)
            }
            
            DispatchQueue.main.async { [self] in
                self.reportSections = sections
            }
        }
    }
    
    func getCategories() {
        Task { [weak self] in
            guard let self else { return }
            let categories = DefaultsService.shared.categories.map { $0.name }
            
            await MainActor.run {
                self.categories = categories
                self.categories.append("")
            }
        }
    }
}

extension CostStatisticsView {
    struct BarItem: Identifiable {
        private(set) var id = UUID().uuidString
        let category: TransactionCategory
        let amount: Int
    }
}

//
//  ReportViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 18.01.2025.
//

import Foundation

extension ReportView {
    final class ViewModel: ObservableObject {
        @Published var fromDate = Date().addOrSubtract(component: .month, value: -1)
        @Published var toDate = Date()
        @Published var reportSections = [ReportView.TransactionSection]()
        @Published var personalCosts = 0
        @Published var businessCosts = 0
    }
}

extension ReportView.ViewModel {
    func getReport() {
        Task { [weak self] in
            guard let self else { return }
            let transactions = DefaultsService.shared.transactions.filter {
                $0.date >= self.fromDate && $0.date <= self.toDate
            }.sorted(by: { $0.date > $1.date })
            
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
            
            let totalCosts = transactions.map { $0.amount }.reduce(0) { $0 + $1 }
            let personalCosts = transactions.filter {
                $0.origin == .personal
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            
            let personalCostsPercent: Int
            if totalCosts != 0 {
                personalCostsPercent = Int(Double(personalCosts) / Double(totalCosts) * 100)
            } else {
                personalCostsPercent = 0
            }
            
            let businessCosts = transactions.filter {
                $0.origin == .business
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            let businessCostsPercent: Int
            if totalCosts != 0 {
                businessCostsPercent = Int(Double(businessCosts) / Double(totalCosts) * 100)
            } else {
                businessCostsPercent = 0
            }
            
            await MainActor.run {
                self.reportSections = sections
                self.personalCosts = personalCostsPercent
                self.businessCosts = businessCostsPercent
            }
        }
    }
}

extension ReportView {
    struct TransactionSection: Identifiable {
        var id = UUID().uuidString
        var title: String
        var items: [TransactionModel]
    }
}

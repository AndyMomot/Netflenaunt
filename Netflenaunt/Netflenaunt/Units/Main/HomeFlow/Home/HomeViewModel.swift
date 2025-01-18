//
//  HomeViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var showOffers = false
        @Published var totalCosts = 0
        @Published var businessCosts = 0
        @Published var personalCosts = 0
        
        @Published var showAddIncome = false
        @Published var showAddCost = false
        @Published var showReport = false
    }
}

extension HomeView.ViewModel {
    func getReport() {
        Task { [weak self] in
            guard let self else { return }
            let transactions = DefaultsService.shared.transactions.filter {
                $0.type == .cost
            }
            
            let totalCosts = transactions.map { $0.amount }.reduce(0) { $0 + $1 }
            
            let personalCosts = transactions.filter {
                $0.origin == .personal
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            
            let businessCosts = transactions.filter {
                $0.origin == .business
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            
            await MainActor.run {
                self.totalCosts = totalCosts
                self.personalCosts = personalCosts
                self.businessCosts = businessCosts
            }
        }
    }
}

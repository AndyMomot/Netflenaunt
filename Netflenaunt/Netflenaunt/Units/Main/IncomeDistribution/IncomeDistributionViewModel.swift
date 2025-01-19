//
//  IncomeDistributionViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 19.01.2025.
//

import Foundation

extension IncomeDistributionView {
    final class ViewModel: ObservableObject {
        @Published var showOffers = false
        @Published var neededIncomePercentage = ""
        
        @Published var businessIncome = 0
        @Published var personalIncome = 0
        
        var updatePercentageTask: Task<Void, Never>?
        
        let offerItems: [OffersView.OfferItem] = [
            .init(
                title: "Analiza dochodów i wydatków:",
                text: "Przeprowadź szczegółową analizę wszystkich swoich dochodów i wydatków. Pomoże Ci to zrozumieć, gdzie możesz obniżyć koszty lub zwiększyć dochody."
            ),
            
                .init(
                    title: "Określenie priorytetów:",
                    text: "Zidentyfikuj kluczowe obszary działalności, które wymagają najwięcej inwestycji (np. marketing, rozwój produktu, wydatki operacyjne) i przydziel budżet zgodnie z priorytetami."
                ),
            
                .init(
                    title: "Formacja rezerwowa:",
                    text: "Posiadanie rezerwy finansowej (np. na nieprzewidziane wydatki) jest ważnym elementem bezpieczeństwa biznesu. Zaleca się przeznaczyć 10-15% całkowitego budżetu."
                ),
        ]
    }
}

extension IncomeDistributionView.ViewModel {
    func getNeededIncomePercentage() {
        Task { [weak self] in
            guard let self else { return }
            let percentage = DefaultsService.shared.neededIncomePercentage
            await MainActor.run {
                self.neededIncomePercentage = "\(percentage)"
            }
        }
    }
    
    func updatePercentage(newValue: String) {
        guard let percentage = Int(newValue) else { return }
        
        // Скасування попереднього завдання
        updatePercentageTask?.cancel()
        
        // Створення нового завдання з затримкою
        updatePercentageTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунди
            
            // Перевірка, чи завдання не було скасоване
            guard !Task.isCancelled else { return }
            
            // Виконання запису
            DefaultsService.shared.neededIncomePercentage = percentage
        }
    }
    
    func getReport() {
        Task { [weak self] in
            guard let self else { return }
            let transactions = DefaultsService.shared.transactions.filter {
                $0.type == .income
            }
            
            let businessIncome = transactions.filter {
                $0.origin == .business
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            
            let personalIncome = transactions.filter {
                $0.origin == .personal
            }.map { $0.amount }.reduce(0) { $0 + $1 }
            
            
            await MainActor.run {
                self.businessIncome = businessIncome
                self.personalIncome = personalIncome
            }
        }
    }
}

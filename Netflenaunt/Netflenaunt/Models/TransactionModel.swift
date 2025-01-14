//
//  TransactionModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import Foundation

struct TransactionModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var type: TransactionType
    var origin: TransactionOrigin
    var amount: Int
    var category: TransactionCategory
    var date: Date
    var comment: String
}

extension TransactionModel {
    enum TransactionOrigin: String, Codable, CaseIterable {
        case business = "Biznes"
        case personal = "Osobisty"
    }
    
    enum TransactionType: String, Codable {
        case income = "Dodawanie dochodu"
        case cost = "Dodawanie kosztów"
    }
}

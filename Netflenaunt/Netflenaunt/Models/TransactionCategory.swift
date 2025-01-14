//
//  TransactionCategory.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import Foundation

struct TransactionCategory: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
}

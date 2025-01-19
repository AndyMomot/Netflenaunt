//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let shared = DefaultsService()
    private let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
    
    var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
}
 
extension DefaultsService {
    var user: User? {
        get {
            if let data = standard.data(forKey: Keys.user.rawValue),
               let user = try? JSONDecoder().decode(User.self, from: data) {
                return user
            }
            return nil
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.user.rawValue)
            }
        }
    }
    
    var transactions: [TransactionModel] {
        get {
            if let data = standard.data(forKey: Keys.transactions.rawValue),
               let items = try? JSONDecoder().decode([TransactionModel].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.transactions.rawValue)
            }
        }
    }
    
    var categories: [TransactionCategory] {
        get {
            if let data = standard.data(forKey: Keys.categories.rawValue),
               let items = try? JSONDecoder().decode([TransactionCategory].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.categories.rawValue)
            }
        }
    }
    
    var neededIncomePercentage: Int {
        get {
            standard.integer(forKey: Keys.neededIncomePercentage.rawValue)
        }
        set {
            standard.set(newValue, forKey: Keys.neededIncomePercentage.rawValue)
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case user
        case transactions
        case categories
        case neededIncomePercentage
    }
}

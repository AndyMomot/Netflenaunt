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
        @Published var totalCosts = 0.0
        @Published var bussinesCosts = 0.0
        @Published var personalCosts = 0.0
    }
}

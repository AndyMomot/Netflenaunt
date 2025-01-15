//
//  OffersViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import Foundation

extension OffersView {
    final class ViewModel: ObservableObject {
        let offerItems: [OfferItem] = [
            .init(title: "Śledzenie trendów:",
                  text: "Przeanalizuj, które koszty rosną, aby określić, czy można je zmniejszyć."),
            .init(title: "Obniżenie kosztów wynajmu:",
                  text: "Jeśli to możliwe, rozważ zmniejszenie rozmiaru lub udostępnienie przestrzeni."),
            .init(title: "Optymalizacja zużycia energii:",
                  text: "Instaluj energooszczędne urządzenia i wdrażaj praktyki oszczędzania energii (wyłączanie urządzeń, używanie oświetlenia LED)."),
            .init(title: "Wdrażanie technologii:",
                  text: "Użyj oprogramowania, aby zautomatyzować wszystkie procesy, zmniejszając koszty pracy ręcznej."),
            .init(title: "Efektywne zarządzanie zapasami:",
                  text: "Zmniejsz nadmiar zapasów, korzystając z systemów zarządzania zapasami do monitorowania popytu."),
            .init(title: "Optymalizacja liczby personelu:",
                  text: "Oceń wydajność każdego pracownika i rozważ jego przekwalifikowanie lub redukcję, jeśli jest to uzasadnione."),
            .init(title: "Oszczędności na reklamie:",
                  text: "Zamiast drogich kampanii reklamowych korzystaj z bezpłatnych lub tanich kanałów promocji (media społecznościowe, content marketing, SEO).")
        ]
    }
}

extension OffersView {
    struct OfferItem: Identifiable {
        private(set) var id = UUID().uuidString
        var title: String
        var text: String
    }
}

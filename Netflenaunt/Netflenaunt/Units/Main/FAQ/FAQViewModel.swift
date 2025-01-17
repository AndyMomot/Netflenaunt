//
//  FAQViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import Foundation

extension FAQView {
    final class ViewModel: ObservableObject {
        @Published var showOffers = false
        
        let faqItems: [FAQView.FAQItem] = [
            .init(
                id: 1,
                title: "Dla kogo jest ta aplikacja?",
                text: "Aplikacja przeznaczona jest dla właścicieli małych firm, którzy chcą efektywnie alokować swoje wydatki osobiste i służbowe, prowadzić ewidencję dochodów oraz kontrolować przepływy finansowe."
            ),
            .init(
                id: 2,
                title: "Jak działa aplikacja?",
                text: """
                Aplikacja umożliwia:
                • Śledź wydatki, automatycznie lub ręcznie przypisując je do celów osobistych lub służbowych.
                • Kategoryzuj wydatki według różnych potrzeb biznesowych.
                • Generowanie raportów do analiz finansowych lub sprawozdawczości podatkowej.
                • Synchronizuj dane z kontami bankowymi i kartami kredytowymi.
                """
            ),
            .init(
                id: 3,
                title: "Jak ręcznie dodać wydatki?",
                text: """
                Aby dodać koszty ręcznie:
                 1. Kliknij przycisk „Dodaj wydatek”.
                 2. Wprowadź kwotę, datę, kategorię i rodzaj wydatku (osobisty lub służbowy).
                 3. Zapisz.
                """
            ),
            .init(
                id: 4,
                title: "Czy istnieje funkcja przypomnienia?",
                text: """
                Tak, aplikacja przypomina o konieczności:
                 • Wprowadź nowe transakcje.
                 • Generuj raporty.
                 • Spłać długi lub zapłać rachunki.
                """
            ),
            .init(
                id: 5,
                title: "Jak sporządzić sprawozdanie finansowe?",
                text: """
                Aby utworzyć raport:
                 1. Otwórz zakładkę „Raporty”.
                 2. Wybierz typ raportu (na przykład „Wydatki biznesowe” lub „Budżet osobisty”).
                 3. Ustaw żądany okres czasu.
                 4. Pobierz raport w formacie PDF lub Excel.
                """
            ),
            .init(
                id: 6,
                title: "Jak skonfigurować kategorie wydatków?",
                text: """
                Przejdź do Ustawienia → Kategorie. Możesz:
                 • Dodaj nowe kategorie.
                 • Edytuj lub usuń istniejące.
                 • Ustaw reguły automatycznej kategoryzacji.
                """
            ),
        ]
    }
}

extension FAQView {
    struct FAQItem: Identifiable {
        var id: Int
        var title: String
        var text: String
    }
}

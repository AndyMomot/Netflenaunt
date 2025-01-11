//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showRegistration = false
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Witamy w Netflenaunt, Twoim partnerze w zarządzaniu finansami! Zacznijmy od rozdzielenia wydatków osobistych i firmowych."
            case .second:
                return "Netflenaunt pomoże Ci kategoryzować transakcje i zyskać jasny obraz wydatków i dochodów. Zarządzanie finansami jeszcze nigdy nie było prostsze!"
            case .third:
                return "Przejmij kontrolę nad finansami dzięki inteligentnym narzędziom i raportom Netflenaunt. Zarządzanie budżetem może być łatwe i wygodne!"
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .first, .second:
                return "Dalej"
            case .third:
                return "Rozpocznij"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var lastIndex: Int {
            OnboardingItem.allCases.last?.rawValue ?? .zero
        }
    }
}

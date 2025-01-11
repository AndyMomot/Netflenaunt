//
//  RegistrationViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import Foundation

extension RegistrationView {
    final class ViewModel: ObservableObject {
        @Published var nickname = ""
        
        func saveNickname(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                DefaultsService.shared.nickname = self.nickname
                completion()
            }
        }
    }
}

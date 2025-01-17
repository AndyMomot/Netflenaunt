//
//  ProfileViewModel.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import Foundation
import UIKit.UIImage

extension ProfileView {
    final class ViewModel: ObservableObject {
        let appStoreURL = URL(string: "https://www.apple.com")
        let supportURL = URL(string: "https://google.com")
        
        @Published var isEditing = false
        @Published var image: UIImage = .init()
        @Published var showImagePicker = false
        @Published var nickname = ""
        
        @Published var showCategoryManagement = false
        
        @Published var showSupport = false
        @Published var showAlert = false
        
        func removeData() {
            Task {
                DefaultsService.shared.removeAll()
                FileManagerService().removeAllFiles()
            }
        }
    }
}

extension ProfileView.ViewModel {
    func getProfile() {
        Task { [weak self] in
            guard let self, let user = DefaultsService.shared.user else { return }
            self.getImage(for: user.id)
            await MainActor.run {
                self.nickname = user.name
            }
        }
    }
    
    func getImage(for id: String) {
        Task { [weak self] in
            guard let self, let imageData = await FileManagerService().fetchImage(with: id),
                  let uiImage = UIImage(data: imageData)
            else { return }
            
            await MainActor.run {
                self.image = uiImage
            }
        }
    }
    
    func setProfile() {
        Task { [weak self] in
            guard let self else { return }
            let shared = DefaultsService.shared
            shared.user?.name = self.nickname
            
            if let id = shared.user?.id,
               self.image != .init(),
               let imageData = self.image.jpegData(compressionQuality: 1) {
                FileManagerService().saveImage(data: imageData, for: id)
            }
        }
    }
}

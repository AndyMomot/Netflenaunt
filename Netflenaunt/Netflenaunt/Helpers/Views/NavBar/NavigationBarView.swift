//
//  NavigationBarView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 12.01.2025.
//

import SwiftUI

struct NavigationBarView: View {
    var action: (ViewAction) -> Void
    
    @State private var user: User?
    @State private var image: Image?
    
    var body: some View {
        HStack(spacing: 14) {
            Button {
                action(.onProfile)
            } label: {
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.deepIndigo)
                        .padding(6)
                        .background(
                            LinearGradient(
                                colors: [.redCustom, .orangeCustom],
                                startPoint: .topTrailing,
                                endPoint: .bottomLeading)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding(.vertical, 4)
                }
            }

            
            Spacer()
            
            Group {
                Text("Cześć, ")
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 17))
                +
                Text(user?.name ?? "przyjaciel")
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 17))
                
            }
            .foregroundStyle(.white)
            
            Button {
                action(.onOffers)
            } label: {
                Asset.offers.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 44)
        .onAppear {
            Task {
                await fetchUser()
            }
        }
    }
}

extension NavigationBarView {
    enum ViewAction {
        case onProfile
        case onOffers
    }
}

private extension NavigationBarView {
    func fetchUser() async {
        if let user = DefaultsService.shared.user {
            await fetchImage(for: user.id)
            
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
    func fetchImage(for id: String) async {
        if let imageData = await FileManagerService().fetchImage(with: id),
           let uiImage = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
            .ignoresSafeArea()
        NavigationBarView() {_ in}
            .padding()
    }
}

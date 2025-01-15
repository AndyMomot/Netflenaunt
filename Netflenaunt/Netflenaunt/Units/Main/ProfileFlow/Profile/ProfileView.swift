//
//  ProfileView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradientBackground()
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                if viewModel.isEditing {
                                    viewModel.setProfile()
                                }
                                viewModel.isEditing.toggle()
                            }
                        } label: {
                            Image(systemName: viewModel.isEditing ? "checkmark.circle" : "pencil")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                                .padding()
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 56) {
                            VStack(spacing: 24) {
                                Group {
                                    if viewModel.image != .init() {
                                        Image(uiImage: viewModel.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: bounds.width * 0.6,
                                                   height: bounds.width * 0.6)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    } else {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: bounds.width * 0.6,
                                                   height: bounds.width * 0.6)
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
                                .onTapGesture {
                                    viewModel.showImagePicker.toggle()
                                }
                                .disabled(!viewModel.isEditing)
                                
                                TextField(text: $viewModel.nickname) {
                                    Text("Wprowadź swój pseudonim")
                                        .foregroundStyle(.gray)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 24))
                                        .multilineTextAlignment(.center)
                                }
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                                .multilineTextAlignment(.center)
                                .disabled(!viewModel.isEditing)
                                
                            }
                            
                            VStack(spacing: 24) {
                                ProfileButton(title: "Zarządzaj kategoriami") {
                                    viewModel.showAddCategory.toggle()
                                }
                                
                                if let url = viewModel.appStoreURL {
                                    ProfileButton(title: "Zaktualizować") {
                                        DispatchQueue.main.async {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                }
                                
                                if viewModel.supportURL != nil {
                                    ProfileButton(title: "Wsparcie") {
                                        viewModel.showSupport.toggle()
                                    }
                                }
                                
                                ProfileButton(title: "Wyczyść dane i wyjdź") {
                                    viewModel.showAlert.toggle()
                                }
                            }
                        }
                        .padding(.vertical, 24)
                        .padding(.horizontal)
                        .background(LinearGradientBackground())
                        .cornerRadius(4, corners: .allCorners)
                        .shadowModifier()
                    }
                    .scrollIndicators(.never)
                }
                .padding()
                
                if viewModel.showAddCategory {
                    AddCategoryView { action in
                        viewModel.handleCategoryView(action: action)
                    }
                    .ignoresSafeArea()
                }
            }
            .onAppear {
                viewModel.getProfile()
            }
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(selectedImage: $viewModel.image)
            }
            .sheet(isPresented: $viewModel.showSupport) {
                SwiftUIViewWebView(url: viewModel.supportURL)
            }
            .alert("Vymažte data a ukončet", isPresented: $viewModel.showAlert) {
                Button("Anulować", role: .cancel) {}
                Button("Potvrdit", role: .destructive) {
                    viewModel.removeData()
                    DispatchQueue.main.async {
                        rootViewModel.setFlow(.onboarding)
                    }
                }
            } message: {
                Text("Czy na pewno chcesz zamknąć aplikację i usunąć wszystkie dane?")
            }
        }
    }
}

#Preview {
    ProfileView()
}

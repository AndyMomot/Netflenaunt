//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 34) {
                ZStack {
                    VStack(spacing: 20) {
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                        
                        Spacer()
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(48, corners: .allCorners)
                    
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 60) {
                            Text(item.text)
                                .foregroundStyle(.black)
                                .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 16))
                                .multilineTextAlignment(.center)
                                .padding(.top, 100)
                            
                            HStack(spacing: 14) {
                                Spacer()
                                ForEach(0..<3, id: \.self) { index in
                                    if index <= currentPageIndex {
                                        Circle()
                                            .fill(.redCustom)
                                            .frame(width: 12)
                                    } else {
                                        Circle()
                                            .stroke(.redCustom, lineWidth: 1)
                                            .frame(width: 12)
                                    }
                                }
                                Spacer()
                            }
                            
                            NextButton(title: item.nextButtonTitle) {
                                withAnimation {
                                    currentPageIndex = item.next.rawValue
                                }
                                
                                if item == .third {
                                    viewModel.showRegistration.toggle()
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom)
                        .background(.white)
                        .cornerRadius(48, corners: .allCorners)
                        .shadow(radius: 10)
                    }
                }
                
                switch item {
                case .first, .second:
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                withAnimation {
                                    currentPageIndex = item.lastIndex
                                }
                            }
                        }
                    } label: {
                        Text("Pominąć")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    }
                case .third:
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                withAnimation {
                                    viewModel.showPrivacyPolicy.toggle()
                                }
                            }
                        }
                    } label: {
                        Group {
                            Text("Zgadzam się z")
                                .foregroundColor(.white)
                                +
                            Text(" polityką prywatności")
                                .foregroundColor(.redCustom)
                        }
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    }
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $viewModel.showRegistration) {
            RegistrationView()
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(2))
}

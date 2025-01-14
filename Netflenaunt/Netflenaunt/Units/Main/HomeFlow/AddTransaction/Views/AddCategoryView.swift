//
//  AddCategoryView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import SwiftUI

struct AddCategoryView: View {
    @State private var text = ""
    
    var action: (ViewAction) -> Void
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
                .blur(radius: 10, opaque: true)
                .opacity(0.8)
                
            
            VStack(spacing: 38) {
                HStack {
                    Text("Dodanie nowej kategorii")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    
                    Spacer()
                    
                    Button {
                        action(.dismiss)
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .padding(17)
                            .background(LinearGradientBackground())
                            .clipShape(Circle())
                    }
                }
                
                CustomTextField(title: "Nazwa kategorii",
                                placeholder: "Wprowadź nazwę kategorii...",
                                text: $text)
                .ignoresSafeArea(.keyboard)
                
                NextButton(title: "Dodaj kategorię") {
                    action(.add(category: text))
                }
                .disabled(text.isEmpty)
                .opacity(text.isEmpty ? 0.5 : 1)
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
            .background(LinearGradientBackground())
            .shadowModifier()
            .padding()
        }
    }
}

extension AddCategoryView {
    enum ViewAction {
        case dismiss
        case add(category: String)
    }
}

#Preview {
    AddCategoryView {_ in}
}

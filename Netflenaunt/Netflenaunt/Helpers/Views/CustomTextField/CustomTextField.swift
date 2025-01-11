//
//  CustomTextField.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 02.12.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String = ""
    var isDynamic = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .foregroundStyle(.white)
            
            if isDynamic {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.mist)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                    
                    
                    if text.isEmpty {
                        createPlaceholder(text: placeholder,
                                          isDynamic: isDynamic)
                    }
                }
                .background(
                    LinearGradient(colors: [.deepIndigo, .deepPlum],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .cornerRadius(8, corners: .allCorners)
                .shadow(color: .ashGray.opacity(0.25), radius: 4,
                        x: -4, y: -4)
                .shadow(color: .black.opacity(0.25), radius: 4,
                        x: 4, y: 4)
                
            } else {
                TextField(text: $text) {
                    createPlaceholder(text: placeholder,
                                      isDynamic: isDynamic)
                }
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                .foregroundStyle(.mist)
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(colors: [.deepIndigo, .deepPlum],
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .cornerRadius(8, corners: .allCorners)
                .shadow(color: .ashGray.opacity(0.25), radius: 4,
                        x: -4, y: -4)
                .shadow(color: .black.opacity(0.25), radius: 4,
                        x: 4, y: 4)
            }
        }
        .hideKeyboardWhenTappedAround()
        .padding(.horizontal, 4)
    }
}

private extension CustomTextField {
    func createPlaceholder(text: String, isDynamic: Bool) -> some View {
        return Text(text)
            .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
            .foregroundStyle(.mist)
            .padding(.horizontal, isDynamic ? 12 : 0)
            .padding(.vertical, isDynamic ? 27 : 0)
            .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
            .ignoresSafeArea()
        
        ScrollView {
            VStack(spacing: 20) {
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                text: .constant("Some text"))
                
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                isDynamic: true,
                                text: .constant("some text"))
            }
            .padding()
        }
    }
}

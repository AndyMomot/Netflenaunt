//
//  FAQCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import SwiftUI

struct FAQCell: View {
    let item: FAQView.FAQItem
    
    @State private var showText = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(item.id).")
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 20))
                .padding(20)
                .background(LinearGradientBackground())
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .shadowModifier()
                .padding(.top, -4)
                .padding(.leading, -4)
                .padding(.bottom, -4)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(item.title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showText.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.white)
                            .padding(4)
                    }
                }
                
                if showText {
                    Text(item.text)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 10))
                }
            }
            .padding(.vertical)
            .padding(.trailing)
        }
        .background(.redCustom)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .shadowModifier()
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        FAQCell(item: .init(
            id: 2,
            title: "Jak działa aplikacja?",
            text: """
            Aplikacja umożliwia:
            • Śledź wydatki, automatycznie lub ręcznie przypisując je do celów osobistych lub służbowych.
            • Kategoryzuj wydatki według różnych potrzeb biznesowych.
            • Generowanie raportów do analiz finansowych lub sprawozdawczości podatkowej.
            • Synchronizuj dane z kontami bankowymi i kartami kredytowymi.
            """
        ))
    }
}

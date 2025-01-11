//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.redCustom)
                
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 15))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .frame(height: 54)
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
            
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}

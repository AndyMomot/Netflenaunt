//
//  CustomProgressView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import SwiftUI

struct CustomProgressView: View {
    let progress: CGFloat
    var backgroundColor: Color = .clear
    var progressColor: Color = .blue
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: geometry.size.width, height: 20)
                    .foregroundColor(backgroundColor)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: max(0, min((progress * geometry.size.width) - 10, geometry.size.width)),
                        height: 16
                    )
                    .foregroundColor(progressColor)
                    .padding(.horizontal, 2)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(progressColor, lineWidth: 1)
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    ZStack {
        Color.gray
        CustomProgressView(progress: 0.5)
            .padding()
    }
}


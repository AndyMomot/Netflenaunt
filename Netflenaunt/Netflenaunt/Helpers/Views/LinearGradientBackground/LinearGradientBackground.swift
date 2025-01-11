//
//  LinearGradientBackground.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 11.01.2025.
//

import SwiftUI

struct LinearGradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [.deepIndigo, .deepPlum],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}

#Preview {
    LinearGradientBackground()
}

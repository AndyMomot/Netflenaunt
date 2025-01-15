//
//  OffersView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 15.01.2025.
//

import SwiftUI

struct OffersView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            LinearGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                BackButton(title: "Propozycje optymalizacji kosztów")
                
                ScrollView {
                    VStack(spacing: 15) {
                        
                        ForEach(viewModel.offerItems) { item in
                            OfferCell(item: item)
                        }
                        
                        Asset.offerBig.swiftUIImage
                            .opacity(0.3)
                        
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
        }
    }
}

#Preview {
    OffersView()
}

//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    private let items: [TabBar.Item] = [
        .init(imageName: Asset.tab1.name),
        .init(imageName: Asset.tab2.name),
        .init(imageName: Asset.tab3.name),
        .init(imageName: Asset.tab4.name),
        .init(imageName: Asset.tab5.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Image(items[selectedItem].imageName)
                .resizable()
                .scaledToFit()
            
            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<items.count, id: \.self) { index in
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                selectedItem = index
                            }
                        }
                    } label: {
                        Rectangle()
                            .scaledToFit()
                            .opacity(.zero)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct TabBarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarCustomView(selectedItem: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}

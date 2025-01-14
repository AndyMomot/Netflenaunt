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
            LinearGradientBackground()
            
            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<items.count, id: \.self) { index in
                    let item = items[index]
                    let isSelected = selectedItem == index
                    
                    Button {
                        DispatchQueue.main.async {
                            withAnimation {
                                selectedItem = index
                            }
                        }
                    } label: {
                        ZStack {
                            if isSelected {
                                Circle()
                                    .fill(.redCustom)
                            }
                            
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 31)
                        }
                        .padding(10)
                        .clipShape(Circle())
                        .offset(y: isSelected ? -20 : 0)
                        .shadow(color: .ashGray.opacity(isSelected ? 0.25 : 0), radius: 4,
                                x: -4, y: -4)
                        .shadow(color: .black.opacity(isSelected ? 0.25 : 0), radius: 4,
                                x: 4, y: 4)
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

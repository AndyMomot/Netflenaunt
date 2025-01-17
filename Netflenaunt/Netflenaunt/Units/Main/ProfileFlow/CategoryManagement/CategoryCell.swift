//
//  CategoryCell.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 17.01.2025.
//

import SwiftUI

struct CategoryCell: View {
    let item: TransactionCategory
    var action: (ViewAction) -> Void
    
    @State private var limitText = "0"
    @State private var canEdit = false
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text(item.name)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 18))
                
                Spacer()
                
                Button {
                    action(.delete(id: item.id))
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.redCustom)
                }
            }
            
            HStack(spacing: 30) {
                CustomTextField(title: "Limit", text: $limitText)
                    .keyboardType(.numberPad)
                    .disabled(!canEdit)
                
                Button {
                    if canEdit {
                        action(.updateLimit(
                            id: item.id,
                            value: Int(limitText) ?? .zero))
                    }
                    
                    withAnimation {
                        canEdit.toggle()
                    }
                } label: {
                    Image(systemName: canEdit ? "checkmark.circle" : "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundStyle(.white)
                }
            }

        }
        .padding()
        .background(LinearGradientBackground())
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .shadowModifier()
        .onAppear {
            limitText = "\(item.limit)"
        }
    }
}

extension CategoryCell {
    enum ViewAction {
        case delete(id: String)
        case updateLimit(id: String, value: Int)
    }
}

#Preview {
    ZStack {
        LinearGradientBackground()
        
        CategoryCell(item: .init(
            name: "Rent",
            limit: 1000
        )) {_ in}
        .padding()
    }
}

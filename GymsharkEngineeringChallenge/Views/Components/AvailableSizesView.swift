//
//  AvailableSizesView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct AvailableSizesView: View {
    let product: Hit
    
    @State var selectedSize: AvailableSize?
    
    var body: some View {
        
        VStack {
            HStack(spacing: 5) {
                ForEach(product.availableSizes, id: \.self) { size in
                    Button {
                        selectedSize = selectedSize == size ? nil : size
                    } label: {
                        Text(size.size.rawValue.uppercased())
                            .font(.subheadline.bold())
                    }
                    .padding(10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(.black, lineWidth: 1)
                            .opacity(selectedSize == size ? 1 : 0.2)
                    )
                    .disabled(size.inventoryQuantity < 1)
                }
            }
            .padding(.vertical, 5)
            
            if let selectedSize = selectedSize {
                Text("\(String(selectedSize.inventoryQuantity)) available")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if !product.inStock {
                Text("Out of Stock")
                    .opacity(0.6)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                        
            Spacer()
        }
        .frame(height: 77)
    }
}

extension AvailableSizesView {
    
}

#Preview {
    AvailableSizesView(product: MockProduct().product)
}

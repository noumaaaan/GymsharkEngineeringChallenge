//
//  AvailableSizesView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let containerSpacing: CGFloat = 5
    static let selectedScale: Double = 1.3
    static let unselectedScale: Double = 0.8
    static let buttonPadding: CGFloat = 10
    static let buttonCornerRadius: CGFloat = 2
    static let buttonBorderColor: Color = .black
    static let buttonBorderWidth: CGFloat = 1
    static let selectedOpacity: Double = 1
    static let unselectedOpacity: Double = 0.2
    static let containerVerticalPadding: CGFloat = 5
    static let availableQuantityColor: Color = .init(hex: "059212")
    static let outOfStockOpacity: Double = 0.6
    static let containerHeight: CGFloat = 77
}

struct AvailableSizesView: View {
    let product: Product
    @State var selectedSize: AvailableSize?
    
    var body: some View {
        VStack {
            sizesSection
            availableQuantitySection
            outOfStockSection
            Spacer()
        }
        .frame(height: Constants.containerHeight)
    }
}

extension AvailableSizesView {
    var sizesSection: some View {
        HStack(spacing: Constants.containerSpacing) {
            ForEach(product.availableSizes, id: \.self) { size in
                Button {
                    withAnimation(.easeInOut) {
                        selectedSize = selectedSize == size ? nil : size
                    }
                } label: {
                    Text(size.size.rawValue.uppercased())
                        .font(.subheadline.bold())
                        .scaleEffect(selectedSize == size ? Constants.selectedScale : Constants.unselectedScale)
                }
                .padding(Constants.buttonPadding)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                        .stroke(Constants.buttonBorderColor, lineWidth: Constants.buttonBorderWidth)
                        .opacity(selectedSize == size ? Constants.selectedOpacity : Constants.unselectedOpacity)
                )
                .disabled(size.inventoryQuantity < 1)
            }
        }
        .padding(.vertical, Constants.containerVerticalPadding)
    }
    
    var availableQuantitySection: some View {
        Group {
            if let selectedSize = selectedSize {
                Text("\(String(selectedSize.inventoryQuantity)) available")
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(Constants.availableQuantityColor)
            }
        }
    }
    
    var outOfStockSection: some View {
        Group {
            if !product.inStock {
                Text("Out of Stock")
                    .opacity(Constants.outOfStockOpacity)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    AvailableSizesView(product: MockProduct().product)
}

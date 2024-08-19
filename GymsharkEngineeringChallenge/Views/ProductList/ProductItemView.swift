//
//  ProductItemView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let inStockImageOpacity: Double = 1
    static let outOfStockImageOpacity: Double = 0.4
    static let labelHorizontalPadding: CGFloat = 5
    static let labelTopPadding: CGFloat = 5
    static let priceAndTitleBottomPadding: CGFloat = 3
}

struct ProductItemView: View {
    let product: Product
    let imageEndpoint: String?
    
    var body: some View {
        VStack {
            featuredImageView
            priceAndTitleSection
        }
    }
}

extension ProductItemView {
    var featuredImageView: some View {
        GSImageView(url: imageEndpoint)
            .opacity(product.inStock ? Constants.inStockImageOpacity : Constants.outOfStockImageOpacity)
            .overlay(alignment: .topLeading) {
                if let labels = product.labels {
                    VStack(alignment: .leading, spacing: .zero) {
                        ForEach(labels, id: \.self) { label in
                            ProductLabelView(label: label.displayLabel, showBackground: product.inStock)
                                .padding(.horizontal, Constants.labelHorizontalPadding)
                                .padding(.top, Constants.labelTopPadding)
                        }
                    }
                }
            }
    }
    
    var priceAndTitleSection: some View {
        VStack(alignment: .leading) {
            Text(product.price)
                .font(.subheadline.bold())
                .foregroundStyle(product.inStock ? .accent : .disabledGrey)
            Text(product.title)
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .font(.footnote.bold())
                .foregroundStyle(product.inStock ? .black : .gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, Constants.priceAndTitleBottomPadding)
    }
}

#Preview {
    ProductItemView(product: MockProduct().product, imageEndpoint: MockProduct().product.featuredMedia?.src)
}

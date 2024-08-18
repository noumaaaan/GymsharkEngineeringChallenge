//
//  ProductDetailsView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let priceTopPadding: CGFloat = 5
    static let sizingSectionTopPadding: CGFloat = 5
    static let mediaHeight: CGFloat = 360
    static let horizontalPadding: CGFloat = 15
}

struct ProductDetailsView: View {
    let product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                mediaSection
                Group {
                    handleSection
                    labelsSection
                    priceTypeAndColorSection
                    sizingSection
                    description
                }
                .padding(.horizontal, Constants.horizontalPadding)
            }
            .navigationTitle(product.title)
        }
    }
}

extension ProductDetailsView {
    var mediaSection: some View {
        VStack {
            TabView {
                ForEach(product.media, id: \.self) { option in
                     GSImageView(url: option.src, height: Constants.mediaHeight)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
       }
        .frame(height: Constants.mediaHeight)
    }
    
    var handleSection: some View {
        Group {
            if let handle = product.handle {
                Text(handle)
                    .lineLimit(2)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var labelsSection: some View {
        Group {
            if let labels = product.labels {
                HStack {
                    ForEach(labels, id:\.self) { label in
                        ProductLabelView(label: label.displayLabel, showBackground: product.inStock)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var priceTypeAndColorSection: some View {
        Group {
            Text(product.price)
                .font(.title2).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.accent)
                .padding(.top, Constants.priceTopPadding)
            
            Text("\(product.type) / \(product.colour)")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var productFitSection: some View {
        Group {
            if let fit = product.fit {
                Text(fit)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var sizingSection: some View {
        AvailableSizesView(product: product)
            .padding(.top, Constants.sizingSectionTopPadding)
    }
    
    var description: some View {
        Text(product.description)
            .font(.callout)
    }
}

#Preview {
    ProductDetailsView(product: MockProduct().product)
}

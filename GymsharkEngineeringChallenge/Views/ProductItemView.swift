//
//  ProductItemView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct ProductItemView: View {
    let product: Hit
    
    var body: some View {
        VStack {
            GSImage(url: product.featuredMedia?.src)
                .opacity(product.inStock ? 1 : 0.35)
            
            VStack(alignment: .leading) {
                Text(product.price.formatted(.currency(code: "GBP")))
                    .font(.subheadline.bold())
                    .foregroundStyle(product.inStock ? .indigo : .gray)
                Text(product.title)
                    .lineLimit(2, reservesSpace: true)
                    .font(.subheadline.bold())
                    .foregroundStyle(product.inStock ? .black : .gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    ProductItemView(product: MockProduct().product)
}

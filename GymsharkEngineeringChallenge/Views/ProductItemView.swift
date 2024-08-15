//
//  ProductItemView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct ProductItemView: View {
    let product: Hit
    let imageEndpoint: String?
    
    var body: some View {
        VStack {
            GSImage(url: imageEndpoint)
                .opacity(product.inStock ? 1 : 0.35)
            
            VStack(alignment: .leading) {
                Text(product.price.formatted(.currency(code: "GBP")))
                    .font(.subheadline.bold())
                    .foregroundStyle(product.inStock ? Color.init(hex: "B51B75") : .gray)
                Text(product.title)
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.leading)
                    .font(.footnote.bold())
                    .foregroundStyle(product.inStock ? .black : .gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 3)
        }
    }
}

#Preview {
    ProductItemView(product: MockProduct().product, imageEndpoint: MockProduct().product.featuredMedia?.src)
}

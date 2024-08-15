//
//  ProductDetailsView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct ProductDetailsView: View {
    let product: Hit
    
    var body: some View {
        VStack {
            if let media = product.media {
                TabView {
                    ForEach(media, id: \.self) { option in
                        GSImage(url: option.src, height: 350)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
            } else {
                GSImage(url: product.featuredMedia?.src)
            }
        }
    }
}

#Preview {
    ProductDetailsView(product: MockProduct().product)
}

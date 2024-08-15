//
//  ProductDetailsView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI
import UIKit

struct ProductDetailsView: View {
    let product: Hit
    
    var body: some View {
        
        VStack {
            mediaSection
            
            ScrollView {
                sizingSection
                    .padding(.horizontal)
           }
        }
        .navigationTitle(product.title)
    }
}

extension ProductDetailsView {
    var mediaSection: some View {
        VStack {
           if let media = product.media {
               TabView {
                   ForEach(media, id: \.self) { option in
                       GSImageView(url: option.src, height: 370)
                   }
               }
               .tabViewStyle(.page(indexDisplayMode: .automatic))
               .indexViewStyle(.page(backgroundDisplayMode: .always))
               
           } else {
               GSImageView(url: product.featuredMedia?.src)
           }
       }
        .frame(height: 360)
    }
    
    var sizingSection: some View {
        AvailableSizesView(product: product)
    }
}

#Preview {
    ProductDetailsView(product: MockProduct().product)
}

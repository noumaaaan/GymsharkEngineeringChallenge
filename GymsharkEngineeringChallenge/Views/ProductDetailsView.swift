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
        
        ScrollView {
            VStack {
                mediaSection
                
                VStack {
                    if let handle = product.handle {
                        Text(handle)
                            .lineLimit(2)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if let labels = product.labels {
                        HStack {
                            ForEach(labels, id:\.self) { label in
                                ProductLabelView(label: label.displayLabel, showBackground: product.inStock)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text(product.price.formatted(.currency(code: "GBP")))
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.init(hex: "B51B75"))
                        .padding(.top, 5)
                    
                    Text("\(product.type) / \(product.colour)")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let fit = product.fit {
                        Text(fit)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    sizingSection
                        .padding(.top, 5)
                    
                    Text(product.description)
                }
                .padding(.horizontal)
            }
            .navigationTitle(product.title)
        }
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
               .indexViewStyle(.page(backgroundDisplayMode: .interactive))
               
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

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
             mediaSection
             Text(product.description)
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
                       GSImage(url: option.src, height: 350)
                   }
               }
               .tabViewStyle(.page(indexDisplayMode: .automatic))
               .indexViewStyle(.page(backgroundDisplayMode: .always))
               
           } else {
               GSImage(url: product.featuredMedia?.src)
           }
       }
        .frame(height: 360)
    }
    
}

#Preview {
    ProductDetailsView(product: MockProduct().product)
}

extension String {
    var decodedHtml: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}

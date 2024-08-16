//
//  GSImageView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct GSImageView: View {
    var url: String?
    var width: CGFloat = 170
    var height: CGFloat = 205
    var backgroundColor: Color = Color.init(hex: "E6E6E6")
    var cornerRadius: CGFloat = 5
    var aspectRatio: ContentMode = .fit
    
    var body: some View {
        VStack {
            if let url = url {
                AsyncImage(url: URL(string: url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: height)
                            .frame(maxWidth: .infinity)
                        
                    } else if phase.error != nil {
                        placeholderView(color: .init(hex: "B51B75"))
                    } else {
                        placeholderView()
                    }
                }
                
            } else {
                placeholderView()
            }
        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension GSImageView {
    func placeholderView(color: Color = .gray) -> some View {
        ZStack {
            backgroundColor
                .frame(height: height)
            
            Image("gslogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    GSImageView(url: nil)
}

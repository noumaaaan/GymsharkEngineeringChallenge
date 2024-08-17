//
//  GSImageView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let imageWidth: CGFloat = 170
    static let imageHeight: CGFloat = 205
    static let imageBackgroundColor: Color = Color.init(hex: "E6E6E6")
    static let imageCornerRadius: CGFloat = 5
    static let gymsharkLogo: String = "gslogo"
    static let logoWidth: CGFloat = 50
}

struct GSImageView: View {
    var url: String?
    var width: CGFloat = Constants.imageWidth
    var height: CGFloat = Constants.imageHeight
    var backgroundColor: Color = Constants.imageBackgroundColor
    var cornerRadius: CGFloat = Constants.imageCornerRadius
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
                        placeholderView(color: .accent)
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
    func placeholderView(color: Color = .disabledGrey) -> some View {
        ZStack {
            backgroundColor
                .frame(height: height)
            
            Image(Constants.gymsharkLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.logoWidth)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    GSImageView(url: nil)
}

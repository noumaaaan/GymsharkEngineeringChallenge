//
//  LoadingView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 17/08/2024.
//

import SwiftUI

private enum Constants {
    static let logo: String = "gslogo"
    static let logoWidth: CGFloat = 100
    static let logoOpacity: Double = 0.3
}

struct LoadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Image(Constants.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.logoWidth)
                    .foregroundStyle(.accent)
                    .opacity(Constants.logoOpacity)
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                    .transition(.opacity)
            }
        }
    }
}

#Preview {
    LoadingView()
}

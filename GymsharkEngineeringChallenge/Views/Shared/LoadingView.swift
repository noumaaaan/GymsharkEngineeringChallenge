//
//  LoadingView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 17/08/2024.
//

import SwiftUI

private enum Constants {
    static let gymsharkHeader: String = "fullgslogo"
    static let gymsharkHeaderWidth: CGFloat = 100
    static let collectionViewHorizontalPadding: CGFloat = 10
}

struct LoadingView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                Image("gslogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.gymsharkHeaderWidth)
                    .foregroundStyle(.accent)
                    .opacity(0.3)
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

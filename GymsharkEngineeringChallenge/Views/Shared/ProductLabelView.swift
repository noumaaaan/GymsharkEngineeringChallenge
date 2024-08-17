//
//  ProductLabelView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let verticalPadding: CGFloat = 5
    static let horizontalPadding: CGFloat = 8
    static let cornerRadius: CGFloat = 10
}

struct ProductLabelView: View {
    let label: String
    var showBackground: Bool = true
    let backgroundColor: Color = .accent
    
    var body: some View {
        Text(label)
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, Constants.verticalPadding)
            .padding(.horizontal, Constants.horizontalPadding)
            .background(showBackground ? backgroundColor : .disabledGrey)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
}

#Preview {
    ProductLabelView(label: "going-fast", showBackground: true)
}

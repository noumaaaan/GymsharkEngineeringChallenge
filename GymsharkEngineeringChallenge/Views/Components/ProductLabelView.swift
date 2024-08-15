//
//  ProductLabelView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct ProductLabelView: View {
    let label: String
    var showBackground: Bool = true
    let backgroundColor: Color = Color.init(hex: "B51B75")
    
    var body: some View {
        Text(label)
            .font(.caption2)
            .foregroundStyle(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(showBackground ? backgroundColor : .gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    ProductLabelView(label: "going-fast", showBackground: true)
}

//
//  CustomAlertView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String?
    let primaryActionTitle: String
    let primaryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3.bold())
                .padding(5)
            
            Text(message ?? "")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineLimit(3, reservesSpace: true)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: primaryAction) {
                Text(primaryActionTitle)
                    .font(.title3)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.black.opacity(0.18), lineWidth: 2)
        )
        .padding()
        .transition(
            .opacity.combined(with: .scale)
            .animation(.bouncy(duration: 0.2, extraBounce: 0.2))
        )
    }
}

#Preview {
    CustomAlertView(
        title: "Test popover!",
        message: "This is a test popover to see this message!",
        primaryActionTitle: "Test Button",
        primaryAction: {}
    )
}

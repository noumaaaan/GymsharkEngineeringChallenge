//
//  CustomAlertView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

private enum Constants {
    static let titlePadding: CGFloat = 5
    static let buttonHorizontalPadding: CGFloat = 30
    static let buttonVerticalPadding: CGFloat = 5
    static let buttonCornerRadius: CGFloat = 8
    
    static let alertBackground: Material = .thinMaterial
    static let alertCornerRadius: CGFloat = 15
    
    static let borderCornerRadius: CGFloat = 15
    static let borderColor: Color = .black
    static let borderOpacity: Double = 0.18
    static let borderWidth: CGFloat = 2
    
    static let animationDuration: Double = 0.2
    static let extraBounce: Double = 0.2
}

struct CustomAlertView: View {
    let title: String
    let message: String?
    let primaryActionTitle: String
    let primaryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3.bold())
                .padding(Constants.titlePadding)
            
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
            .padding(.horizontal, Constants.buttonHorizontalPadding)
            .padding(.vertical, Constants.buttonVerticalPadding)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: Constants.buttonCornerRadius))
        }
        .padding()
        .background(Constants.alertBackground)
        .clipShape(RoundedRectangle(cornerRadius: Constants.alertCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Constants.borderCornerRadius)
                .stroke(
                    Constants.borderColor
                        .opacity(Constants.borderOpacity),
                    lineWidth: Constants.borderWidth
                )
        )
        .padding()
        .transition(
            .opacity.combined(with: .scale)
            .animation(.bouncy(duration: Constants.animationDuration, extraBounce: Constants.extraBounce))
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

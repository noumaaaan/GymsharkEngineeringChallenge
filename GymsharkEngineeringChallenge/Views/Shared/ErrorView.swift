//
//  ErrorView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 18/08/2024.
//

import SwiftUI

private enum Constants {
    static let titlePadding: CGFloat = 5
    static let buttonHorizontalPadding: CGFloat = 20
    static let buttonVerticalPadding: CGFloat = 10
    static let buttonToMessagePadding: CGFloat = 10
    static let buttonCornerRadius: CGFloat = 8
    static let animationDuration: Double = 0.2
    static let extraBounce: Double = 0.2
}

struct ErrorView: View {
    var title: String = "Something went wrong"
    let errorMessage: String?
    var primaryActionTitle: String = "Try again"
    let primaryAction: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3.bold())
                .padding(Constants.titlePadding)
            
            Text(errorMessage ?? "")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button(action: primaryAction) {
                Text(primaryActionTitle)
                    .font(.subheadline).bold()
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, Constants.buttonHorizontalPadding)
            .padding(.vertical, Constants.buttonVerticalPadding)
            .background(.accent)
            .clipShape(RoundedRectangle(cornerRadius: Constants.buttonCornerRadius))
            .padding(.vertical, Constants.buttonToMessagePadding)
        }
        .transition(.opacity)
    }
}

#Preview {
    ErrorView(
        title: "Something went wrong",
        errorMessage: "This is an error message showing that there's an error which is not good.",
        primaryActionTitle: "Try again"
    ) {
    }
}

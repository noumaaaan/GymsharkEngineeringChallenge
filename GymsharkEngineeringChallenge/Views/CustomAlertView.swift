//
//  CustomAlertView.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    let primaryAction: () -> ()
    let dismissAction: () -> ()
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title2.bold())
                .padding()
            
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Button {
                primaryAction()
            } label: {
                Text(buttonTitle)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
            }
            .padding()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                dismissAction()
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding()
    }
}

#Preview {
    CustomAlertView(
        title: "Test popover",
        message: "This is a test popover to see this message",
        buttonTitle: "Button",
        primaryAction: {},
        dismissAction: {}
    )
}

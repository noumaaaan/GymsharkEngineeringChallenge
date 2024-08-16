//
//  HiddenModifier.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 16/08/2024.
//

import Foundation
import SwiftUI

/// Conditionally hide views based on a Bool value.
extension View {
    public func hidden(_ shouldHide: Bool) -> some View {
        modifier(HiddenModifier(isHidden: shouldHide))
    }
}

private struct HiddenModifier: ViewModifier {
    private let isHidden: Bool

    init(isHidden: Bool) {
        self.isHidden = isHidden
    }

    func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}

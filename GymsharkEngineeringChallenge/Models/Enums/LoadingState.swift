//
//  GSLoadingState.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 17/08/2024.
//

import Foundation

enum GSLoadingState: Equatable {
    case uninitialized
    case loading
    case loaded
    case emptyLoaded
    case failure(error: Error)
    
    static func == (lhs: GSLoadingState, rhs: GSLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.uninitialized, .uninitialized),
             (.loading, .loading),
             (.loaded, .loaded),
             (.emptyLoaded, .emptyLoaded):
            return true
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

//
//  SortOption.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 16/08/2024.
//

import Foundation

enum SortOption: CaseIterable {
    case priceAscending
    case priceDescending
    
    var label: String {
        switch self {
        case .priceAscending: return "Price ascending"
        case .priceDescending: return "Price descending"
        }
    }
    
    var image: String {
        switch self {
        case .priceAscending: return "arrow.up.circle"
        case .priceDescending: return "arrow.down.circle"
        }
    }
}

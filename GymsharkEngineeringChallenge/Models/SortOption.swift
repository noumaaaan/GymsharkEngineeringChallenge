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
        case .priceAscending: "Price ascending"
        case .priceDescending: "Price descending"
        }
    }
    
    var image: String {
        switch self {
        case .priceAscending: "arrow.up.circle"
        case .priceDescending: "arrow.down.circle"
        }
    }
}

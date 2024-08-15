//
//  Products.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

// MARK: - Products
struct Products: Codable, Hashable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable, Hashable {
    let id: Int
    let sku: String
    let inStock: Bool
    let sizeInStock: [Size]?
    let availableSizes: [AvailableSize]
    let handle: String?
    let title: String
    var description: String
    let type: String
    let fit: String?
    let labels: [Labels]?
    let colour: String
    let price: Int
    let featuredMedia: Media?
    let media: [Media]?
}

// MARK: - Size
enum Size: String, Codable {
    case xs = "xs"
    case s = "s"
    case m = "m"
    case l = "l"
    case xl = "xl"
    case xxl = "xxl"
}

// MARK: - Size
enum Labels: String, Codable {
    case goingFast = "going-fast"
    case popular = "popular"
    case limitedEdition = "limited-edition"
    case new = "new"
    case recycledNylon = "recycled-nylon"
    case recycledPolyester = "recycled-polyester"
    
    var displayLabel: String {
        switch self {
        case .goingFast: "Going Fast"
        case .popular: "Popular"
        case .limitedEdition: "Limited Edition"
        case .new: "New"
        case .recycledNylon: "Recycled Nylon"
        case .recycledPolyester: "Recycled Polyester"
        }
    }
}

// MARK: - AvailableSize
struct AvailableSize: Codable, Hashable {
    let inStock: Bool
    let inventoryQuantity: Int
    let size: Size
    let price: Int
}

// MARK: - Media
struct Media: Codable, Hashable {
    let src: String?
}

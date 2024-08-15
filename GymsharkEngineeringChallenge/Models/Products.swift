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
    let sku: String?
    let inStock: Bool
    let sizeInStock: [Size]?
    let availableSizes: [AvailableSize]?
    let handle: String?
    let title: String
    let description: String?
    let type: String?
    let fit: String?
    let labels: [String]?
    let colour: String?
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
    case xxxl = "xxxl"
}

// MARK: - AvailableSize
struct AvailableSize: Codable, Hashable {
    let inStock: Bool
    let inventoryQuantity: Int
    let size: Size
}

// MARK: - Media
struct Media: Codable, Hashable {
    let src: String?
}


//
//  Products.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

// MARK: - Products
struct Products: Codable, Hashable {
    let hits: [Product]
}

// MARK: - Hit
struct Product: Identifiable, Codable, Hashable {
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
    let price: String
    let featuredMedia: Media?
    let media: [Media]
    
    // Reduce the thumbnail fetch to improve performance -> https://cdn.shopify.com/
    var optimisedFeatureMediaURL: String? {
        return featuredMedia?.src?.replacingOccurrences(of: "(\\?.*)$", with: "?width=380", options: .regularExpression)
    }
}

// MARK: - AvailableSize
struct AvailableSize: Codable, Hashable {
    let inStock: Bool
    let inventoryQuantity: Int
    let size: Size
    let price: Int
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

// MARK: - Media
struct Media: Codable, Hashable {
    let src: String?
}

extension Product {
    init(from dto: ProductDTO) {
        self.id = dto.id
        self.sku = dto.sku
        self.inStock = dto.inStock
        self.sizeInStock = dto.sizeInStock?.compactMap { Size(rawValue: $0.rawValue) }
        self.availableSizes = dto.availableSizes.map { AvailableSize(from: $0) }
        self.handle = dto.handle
        self.title = dto.title
        self.description = dto.description.decodedHtml // Decode HTML here
        self.type = dto.type
        self.fit = dto.fit
        self.labels = dto.labels?.compactMap { Labels(rawValue: $0.rawValue) }
        self.colour = dto.colour
        self.price = dto.price.formatted(.currency(code: "GBP"))
        self.featuredMedia = dto.featuredMedia.map { Media(src: $0.src) }
        self.media = dto.media.map { Media(src: $0.src) }
    }
}

extension AvailableSize {
    init(from dto: AvailableSizeDTO) {
        self.inStock = dto.inStock
        self.inventoryQuantity = dto.inventoryQuantity
        self.size = Size(rawValue: dto.size.rawValue) ?? .m
        self.price = dto.price
    }
}

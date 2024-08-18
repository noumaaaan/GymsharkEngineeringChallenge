//
//  ProductsDTO.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 16/08/2024.
//

import Foundation

// MARK: - ProductsDTO
struct ProductsDTO: Decodable {
    let hits: [ProductDTO]
}

// MARK: - ProductDTO
struct ProductDTO: Decodable, Identifiable {
    let id: Int
    let sku: String
    let inStock: Bool
    let sizeInStock: [SizeDTO]?
    let availableSizes: [AvailableSizeDTO]
    let handle: String?
    let title: String
    let description: String
    let type: String
    let fit: String?
    let labels: [LabelsDTO]?
    let colour: String
    let price: Int
    let featuredMedia: MediaDTO?
    let media: [MediaDTO]
}

// MARK: - AvailableSizeDTO
struct AvailableSizeDTO: Decodable {
    let inStock: Bool
    let inventoryQuantity: Int
    let size: SizeDTO
    let price: Int
}

// MARK: - SizeDTO
enum SizeDTO: String, Decodable {
    case xs
    case s
    case m
    case l
    case xl
    case xxl
}

// MARK: - LabelsDTO
enum LabelsDTO: String, Decodable {
    case goingFast = "going-fast"
    case popular = "popular"
    case limitedEdition = "limited-edition"
    case new = "new"
    case recycledNylon = "recycled-nylon"
    case recycledPolyester = "recycled-polyester"
}

// MARK: - MediaDTO
struct MediaDTO: Decodable {
    let src: String?
}

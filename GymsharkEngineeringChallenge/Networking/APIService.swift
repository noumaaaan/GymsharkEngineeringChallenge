//
//  APIService.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

final class APIService {
    
    /// Endpoint.
    static let endpoint = "https://cdn.develop.gymshark.com/training/mock-product-responses/algolia-example-payload.json"
    
    /// Fetches a list of products from the API returning [Product].
    func fetchProducts(urlString: String = endpoint) async throws -> [Product] {
        guard let url = URL(string: urlString) else { throw GSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299 else { throw GSError.invalidResponse }
        
        let decoder = JSONDecoder()
        guard let productsDTO = try? decoder.decode(ProductsDTO.self, from: data) else { throw GSError.invalidData }
        
        return productsDTO.hits.map { Product(from: $0) }
    }
}


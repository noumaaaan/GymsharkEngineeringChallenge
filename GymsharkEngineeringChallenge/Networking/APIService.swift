//
//  APIService.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

final class APIService {
    static func fetchProducts() async throws -> [Hit] {
        do {
            let urlString = "https://cdn.develop.gymshark.com/training/mock-product-responses/algolia-example-payload.json"
            guard let url = URL(string: urlString) else { throw GSError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299 else {
                throw GSError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            guard let products = try? decoder.decode(Products.self, from: data).hits else {
                throw GSError.invalidData
            }
            return products
            
        } catch {
            print(error)
            throw GSError.unknownError(error)
        }
    }
}

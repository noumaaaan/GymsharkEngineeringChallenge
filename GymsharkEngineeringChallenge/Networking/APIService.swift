//
//  APIService.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

final class APIService {
    static func getProducts() async throws -> [Hit] {
        let urlString = "https://cdn.develop.gymshark.com/training/mock-product-responses/algolia-example-payload.json"
        guard let url = URL(string: urlString) else { throw GSError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299 else {
            throw GSError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Products.self, from: data).hits
            
        } catch {
            print(error)
            throw GSError.invalidData
        }
    }
}

//
//  GSError.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

enum GSError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: 
            return "The provided URL is invalid."
            
        case .invalidResponse:
            return "The response received from the server is invalid. Please check your connection or permissions and try again."
            
        case .invalidData:
            return "The data received from the server is invalid or corrupted."
            
        case .unknownError(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
}

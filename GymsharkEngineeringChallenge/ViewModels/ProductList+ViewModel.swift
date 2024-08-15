//
//  ProductList+ViewModel.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
final class ProductListViewModel: ObservableObject {
    
    @Published var products: [Hit] = []
    @Published var shouldShowAlert = false
    @Published var error: GSError?
    @Published var isAlertPresented: Bool = false
    
    func fetchProducts() async {
        do {
            self.products = try await APIService.getProducts()
            for index in products.indices {
                products[index].description = products[index].description.decodedHtml.trimmingCharacters(in: .whitespaces)
            }
            
        } catch {
            shouldShowAlert = true
            self.error = error as? GSError
        }
    }
    
    func refreshList() async {
        self.products.removeAll()
        await fetchProducts()
    }
    
    // Reduce the thumbnail fetch to improve performance -> https://cdn.shopify.com/
    func optimiseImageEndpoint(endpoint: String?) -> String? {
        return endpoint?.replacingOccurrences(of: "(\\?.*)$", with: "?width=380", options: .regularExpression)
    }
}

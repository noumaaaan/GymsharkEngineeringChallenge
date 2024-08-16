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
    @Published var selectedSortOption: SortOption?
        
    @Published var error: GSError?
    @Published var shouldShowAlert = false
    @Published var isAlertPresented: Bool = false
    
    init() {
        Task {
            await fetchProducts()
        }
    }
    
    func fetchProducts() async {
        
        Task {
            do {
                print("Fetched products")
                self.products = try await APIService.getProducts()
                for index in products.indices {
                    products[index].description = products[index].description.decodedHtml.trimmingCharacters(in: .whitespaces)
                }
                
            } catch {
                self.error = error as? GSError
            }
        }
    }
    
    func refreshList() async {
        self.products.removeAll()
        selectedSortOption = nil
        await fetchProducts()
    }
    
    func sortResults(sortOption: SortOption) {
        
        selectedSortOption = sortOption
        
        switch sortOption {
        case .priceAscending:
            products = products.sorted(by: { $0.price < $1.price })
        case .priceDescending:
            products = products.sorted(by: { $0.price > $1.price })
        }
    }
    
    // Reduce the thumbnail fetch to improve performance -> https://cdn.shopify.com/
    func optimiseImageEndpoint(endpoint: String?) -> String? {
        return endpoint?.replacingOccurrences(of: "(\\?.*)$", with: "?width=380", options: .regularExpression)
    }
}

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

extension String {
    var decodedHtml: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}

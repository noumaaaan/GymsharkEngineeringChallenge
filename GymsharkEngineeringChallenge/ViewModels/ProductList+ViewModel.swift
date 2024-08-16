//
//  ProductList+ViewModel.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation
import SwiftUI

@MainActor
final class ProductListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var selectedSortOption: SortOption?
    @Published var error: Error?
    @Published var showAlert = false
    
    init() {
        loadData()
    }
    
    func loadData() {
        Task {
            try await fetchProducts()
        }
    }
    
    func fetchProducts() async throws {
        do {
            let urlString = "https://cdn.develop.gymshark.com/training/mock-product-responses/algolia-example-payload.json"
            guard let url = URL(string: urlString) else { throw GSError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 299 else {
                throw GSError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            guard let productsDTO = try? decoder.decode(ProductsDTO.self, from: data) else { throw GSError.invalidData }
            self.products = productsDTO.hits.map { Product(from: $0) }
            
        } catch {
            print(error.localizedDescription)
            self.error = error
        }
    }
    
    func toggleAlert(error: Error?) {
        if error != nil {
            showAlert.toggle()
        }
    }

    func refreshList() {
        products.removeAll()
        error = nil
        showAlert = false
        selectedSortOption = nil
        loadData()
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
//    func optimiseImageEndpoint(endpoint: String?) -> String? {
//        return endpoint?.replacingOccurrences(of: "(\\?.*)$", with: "?width=380", options: .regularExpression)
//    }
}




//            for index in products.indices {
//                products[index].description = products[index].description.decodedHtml.trimmingCharacters(in: .whitespaces)
//            }


//    func fetchProducts() async {
//        Task {
//            do {
//                print("Fetched products")
//                self.products = try await APIService.getProducts()
//                for index in products.indices {
//                    products[index].description = products[index].description.decodedHtml.trimmingCharacters(in: .whitespaces)
//                }
//            } catch {
//                self.error = error as? GSError
//            }
//        }
//    }
    
//    func refreshList() async {
//        self.products.removeAll()
//        selectedSortOption = nil
//        await fetchProducts()
//    }

//    @Published var shouldShowAlert = false
//    @Published var isAlertPresented: Bool = false
    
//    init() {
//        Task {
//            await fetchProducts()
//        }
//    }

//extension String {
//    var decodedHtml: String {
//        let attr = try? NSAttributedString(data: Data(utf8), options: [
//            .documentType: NSAttributedString.DocumentType.html,
//            .characterEncoding: String.Encoding.utf8.rawValue
//        ], documentAttributes: nil)
//
//        return attr?.string ?? self
//    }
//}

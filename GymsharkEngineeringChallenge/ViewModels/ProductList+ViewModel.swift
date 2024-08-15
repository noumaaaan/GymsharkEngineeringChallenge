//
//  ProductList+ViewModel.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    
    @Published var products: [Hit] = []
    @Published var shouldShowAlert = false
    @Published var error: GSError?
    @Published var isAlertPresented: Bool = false
    
    func fetchProducts() async {
        do {
            self.products = try await APIService.getProducts()
        } catch {
            shouldShowAlert = true
            self.error = error as? GSError
        }
    }
    
    func refreshList() async {
        self.products.removeAll()
        await fetchProducts()
    }
}

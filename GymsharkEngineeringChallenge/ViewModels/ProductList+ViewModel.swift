//
//  ProductList+ViewModel.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation
import SwiftUI

enum LoadingState: CaseIterable {
    case uninitialized
    case loading
    case loaded
    case empty
}

@MainActor
final class ProductListViewModel: ObservableObject {
    
    /// Collection to hold Product object.
    @Published var products: [Product] = []
    /// The selected SortOption used to show selected state and compute sorting.
    @Published var selectedSortOption: SortOption?
    /// Assess whether the sort menu should be shown or not.
    @Published var sortingMenuShown = false
    /// Holds any errors that may be thrown.
    @Published var error: Error?
    /// Property to decide whether an alert should be shown to the user.
    @Published var showAlert = false
    
    @Published var loadingState: LoadingState = .uninitialized
    
    /// APIservice used for fetching product data.
    private let apiService: APIService
    
    /// Initialises the APIService and loads the initial data.
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        loadData()
    }
    
    /// Starts an asynchronous task to fetch products from the API.
    func loadData() {
        Task {
            do {
                loadingState = .loading
                try await fetchProducts()
            } catch {
                self.error = error
                showAlert = true
            }
        }
    }
    
    /// Set the state of the alert to hidden.
    func hideAlert() {
        self.showAlert = false
    }
        
    /// Fetches products from the APIservice and updates the products array.
    func fetchProducts() async throws {
        self.products = try await apiService.fetchProducts()
        isSortingMenuShown()
        
        loadingState = products.count > 0 ? .loaded : .empty
    }
    
    /// Updates the state to show or hide the sorting menu based on the number of products.
    func isSortingMenuShown() {
        sortingMenuShown = products.count > 1 ? false : true
    }
    
    /// Clears the product list, resets sorting, clears errors, and reloads data.
    func refreshList() async {
        self.error = nil
        self.showAlert = false
        self.selectedSortOption = nil
        self.products.removeAll()
        isSortingMenuShown()
        loadData()
    }
    
    /// Sorts the products based on the selected sort option and updates the products array.
    func sortResults(sortOption: SortOption) {
        selectedSortOption = sortOption
        switch sortOption {
        case .priceAscending:
            products = products.sorted(by: { $0.price < $1.price })
        case .priceDescending:
            products = products.sorted(by: { $0.price > $1.price })
        }
    }
}

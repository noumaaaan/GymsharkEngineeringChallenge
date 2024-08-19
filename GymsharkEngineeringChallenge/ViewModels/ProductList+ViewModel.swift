//
//  ProductList+ViewModel.swift
//  GymsharkEngineeringChallenge
//
//  Created by Noumaan Mehmood on 15/08/2024.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    
    /// Collection to hold Product object.
    @Published private(set) var products: [Product] = []
    /// Indicates the current Loading State.
    @Published private(set) var loadingState: GSLoadingState = .uninitialized
    /// The selected SortOption used to show selected state and compute sorting.
    @Published var selectedSortOption: SortOption?
    /// Assess whether the sort menu should be shown or not.
    var sortingMenuShown: Bool {
        !products.isEmpty
    }
    
    /// APIservice used for fetching product data.
    private let apiService: APIService
    
    /// Initialises the APIService and loads the initial data.
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        loadData()
    }
    
    /// Starts a  task to fetch products from the API.
    func loadData() {
        Task {
            self.loadingState = .loading
            do {
                try await fetchProducts()
            } catch {
                self.loadingState = .failure(error: error)
            }
        }
    }
        
    /// Fetches products from the APIservice and updates the products array.
    func fetchProducts() async throws {
        self.products = try await apiService.fetchProducts()
        loadingState = products.isEmpty ? .emptyLoaded : .loaded
    }

    /// Clears the product list, resets sorting and reloads data.
    func refreshList() {
        self.selectedSortOption = nil
        self.products.removeAll()
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

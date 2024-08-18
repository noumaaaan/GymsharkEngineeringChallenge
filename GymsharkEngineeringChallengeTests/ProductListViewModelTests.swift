//
//  ProductListViewModelTests.swift
//  GymsharkEngineeringChallengeTests
//
//  Created by Noumaan Mehmood on 17/08/2024.
//

import XCTest
@testable import GymsharkEngineeringChallenge

@MainActor
final class ProductListViewModelTests: XCTestCase {

    // Mock APIService to simulate success and error scenarios
    class MockAPIService: APIService {
        var shouldReturnError = false
        var mockProducts: [Product] = []
        
        override func fetchProducts(urlString: String = APIService.endpoint) async throws -> [Product] {
            if shouldReturnError {
                throw GSError.invalidResponse
            }
            return mockProducts
        }
    }
    
    func testLoadDataSuccess() async {
        // Arrange
        let mockService = MockAPIService()
        mockService.mockProducts = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product 1",
                description: "Description 1",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            ),
            Product(
                id: 2,
                sku: "SKU2",
                inStock: true,
                sizeInStock: [.l],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 3, size: .l, price: 30)],
                handle: "product-2",
                title: "Product 2",
                description: "Description 2",
                type: "Type 2",
                fit: "Fit 2",
                labels: [.popular],
                colour: "Blue",
                price: "£30.00",
                featuredMedia: Media(src: "https://example.com/image2"),
                media: [Media(src: "https://example.com/image2")]
            )
        ]
        let viewModel = ProductListViewModel(apiService: mockService)
        
        // Act
        viewModel.loadData()
        
        // Assert
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.first?.title, "Product 1")
        XCTAssertEqual(viewModel.loadingState, .loaded)
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testLoadDataFailure() async {
        // Arrange
        let mockService = MockAPIService()
        mockService.shouldReturnError = true
        let viewModel = ProductListViewModel(apiService: mockService)
        
        // Act
        viewModel.loadData()
        
        // Assert
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.loadingState, .uninitialized)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.localizedDescription, GSError.invalidResponse.localizedDescription)
    }
    
    func testSortResultsByPriceAscending() {
        // Arrange
        let viewModel = ProductListViewModel(apiService: MockAPIService())
        viewModel.products = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product B",
                description: "Description B",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            ),
            Product(
                id: 2,
                sku: "SKU2",
                inStock: true,
                sizeInStock: [.l],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 3, size: .l, price: 10)],
                handle: "product-2",
                title: "Product A",
                description: "Description A",
                type: "Type 2",
                fit: "Fit 2",
                labels: [.popular],
                colour: "Blue",
                price: "£10.00",
                featuredMedia: Media(src: "https://example.com/image2"),
                media: [Media(src: "https://example.com/image2")]
            )
        ]
        
        // Act
        viewModel.sortResults(sortOption: .priceAscending)
        
        // Assert
        XCTAssertEqual(viewModel.products.first?.title, "Product A")
        XCTAssertEqual(viewModel.products.last?.title, "Product B")
    }
    
    func testSortResultsByPriceDescending() {
        // Arrange
        let viewModel = ProductListViewModel(apiService: MockAPIService())
        viewModel.products = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 10)],
                handle: "product-1",
                title: "Product A",
                description: "Description A",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£10.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            ),
            Product(
                id: 2,
                sku: "SKU2",
                inStock: true,
                sizeInStock: [.l],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 3, size: .l, price: 20)],
                handle: "product-2",
                title: "Product B",
                description: "Description B",
                type: "Type 2",
                fit: "Fit 2",
                labels: [.popular],
                colour: "Blue",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image2"),
                media: [Media(src: "https://example.com/image2")]
            )
        ]
        
        // Act
        viewModel.sortResults(sortOption: .priceDescending)
        
        // Assert
        XCTAssertEqual(viewModel.products.first?.title, "Product B")
        XCTAssertEqual(viewModel.products.last?.title, "Product A")
    }
    
    func testSortingMenuVisibility() {
        // Arrange
        let viewModel = ProductListViewModel(apiService: MockAPIService())
        
        // Act
        viewModel.products = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product 1",
                description: "Description 1",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            )
        ]
        viewModel.isSortingMenuShown()
        
        // Assert
        XCTAssertTrue(viewModel.sortingMenuShown)
        
        // Act
        viewModel.products = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product 1",
                description: "Description 1",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            ),
            Product(
                id: 2,
                sku: "SKU2",
                inStock: true,
                sizeInStock: [.l],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 3, size: .l, price: 30)],
                handle: "product-2",
                title: "Product 2",
                description: "Description 2",
                type: "Type 2",
                fit: "Fit 2",
                labels: [.popular],
                colour: "Blue",
                price: "£30.00",
                featuredMedia: Media(src: "https://example.com/image2"),
                media: [Media(src: "https://example.com/image2")]
            )
        ]
        viewModel.isSortingMenuShown()
        
        // Assert
        XCTAssertFalse(viewModel.sortingMenuShown)
    }
    
    func testRefreshList() async {
        // Arrange
        let mockService = MockAPIService()
        mockService.mockProducts = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product 1",
                description: "Description 1",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            ),
            Product(
                id: 2,
                sku: "SKU2",
                inStock: true,
                sizeInStock: [.l],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 3, size: .l, price: 30)],
                handle: "product-2",
                title: "Product 2",
                description: "Description 2",
                type: "Type 2",
                fit: "Fit 2",
                labels: [.popular],
                colour: "Blue",
                price: "£30.00",
                featuredMedia: Media(src: "https://example.com/image2"),
                media: [Media(src: "https://example.com/image2")]
            )
        ]
        let viewModel = ProductListViewModel(apiService: mockService)
        
        // Precondition: Load some data initially
        viewModel.loadData()
        XCTAssertEqual(viewModel.products.count, 2)
        
        // Act: Refresh the list
        await viewModel.refreshList()
        
        // Assert: Ensure products are cleared and then reloaded
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.loadingState, .loaded)
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testHideAlertFunctionality() {
        // Arrange
        let viewModel = ProductListViewModel(apiService: MockAPIService())
        viewModel.showAlert = true
        
        // Act
        viewModel.hideAlert()
        
        // Assert
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testLoadingStateTransitions() async {
        // Arrange
        let mockService = MockAPIService()
        let viewModel = ProductListViewModel(apiService: mockService)
        
        // Precondition: Ensure initial state is uninitialized
        XCTAssertEqual(viewModel.loadingState, .uninitialized)
        
        // Act: Start loading data
        mockService.mockProducts = [
            Product(
                id: 1,
                sku: "SKU1",
                inStock: true,
                sizeInStock: [.s, .m],
                availableSizes: [AvailableSize(inStock: true, inventoryQuantity: 5, size: .s, price: 20)],
                handle: "product-1",
                title: "Product 1",
                description: "Description 1",
                type: "Type 1",
                fit: "Fit 1",
                labels: [.new],
                colour: "Red",
                price: "£20.00",
                featuredMedia: Media(src: "https://example.com/image1"),
                media: [Media(src: "https://example.com/image1")]
            )
        ]
        viewModel.loadData()
        
        // Assert: State should now be loaded
        XCTAssertEqual(viewModel.loadingState, .loaded)
        
        // Act: Simulate an error during loading
        mockService.shouldReturnError = true
        viewModel.loadData()
        
        // Assert: State should revert to uninitialized due to the error
        XCTAssertEqual(viewModel.loadingState, .uninitialized)
    }
}

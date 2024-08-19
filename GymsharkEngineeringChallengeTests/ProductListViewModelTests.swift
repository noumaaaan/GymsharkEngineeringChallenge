//
//  ProductListViewModelTests.swift
//  GymsharkEngineeringChallengeTests
//
//  Created by Noumaan Mehmood on 18/08/2024.
//

import XCTest
@testable import GymsharkEngineeringChallenge

@MainActor
class ProductListViewModelTests: XCTestCase {
    
    var viewModel: ProductListViewModel!
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        viewModel = ProductListViewModel()
        apiService = APIService()
    }
    
    override func tearDown() {
        viewModel = nil
        apiService = nil
        super.tearDown()
    }
    
    func test_initial_state() {
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.loadingState, .uninitialized)
        XCTAssertNil(viewModel.selectedSortOption)
        XCTAssertFalse(viewModel.sortingMenuShown)
    }
  
    
    func test_products_successfully_loaded() async throws {
        let expectation = XCTestExpectation(description: "Load products from API")
        viewModel.loadData()
        
        XCTAssertEqual(viewModel.loadingState, .loading)
        
        for _ in 0..<100 {
            if viewModel.loadingState == .loaded {
                expectation.fulfill()
                break
            }
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        }
        
        await fulfillment(of: [expectation], timeout: 10)
        
        XCTAssertFalse(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.loadingState, .loaded)
        XCTAssertTrue(viewModel.sortingMenuShown)
    }
    
    func test_sort_results_ascending() async throws {
        let expectation = XCTestExpectation(description: "Products are sorted ascending")
        viewModel.loadData()
        
        for _ in 0..<100 {
            if viewModel.loadingState == .loaded {
                expectation.fulfill()
                break
            }
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        }
        
        await fulfillment(of: [expectation], timeout: 10)
        
        viewModel.sortResults(sortOption: .priceAscending)
        XCTAssertEqual(viewModel.selectedSortOption, .priceAscending)
        XCTAssertTrue(viewModel.products == viewModel.products.sorted(by: { $0.price < $1.price}))
    }

    
    func test_sort_results_descending() async throws {
        let expectation = XCTestExpectation(description: "Products are sorted descending")
        viewModel.loadData()
        
        for _ in 0..<100 {
            if viewModel.loadingState == .loaded {
                expectation.fulfill()
                break
            }
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        }
        
        await fulfillment(of: [expectation], timeout: 10)
        
        viewModel.sortResults(sortOption: .priceDescending)
        XCTAssertEqual(viewModel.selectedSortOption, .priceDescending)
        XCTAssertTrue(viewModel.products == viewModel.products.sorted(by: { $0.price > $1.price}))
    }
}

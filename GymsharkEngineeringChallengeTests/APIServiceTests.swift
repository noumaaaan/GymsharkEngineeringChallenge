//
//  APIServiceTests.swift
//  GymsharkEngineeringChallengeTests
//
//  Created by Noumaan Mehmood on 18/08/2024.
//

import XCTest
@testable import GymsharkEngineeringChallenge

final class APIServiceTests: XCTestCase {

    var apiService: APIService!

    override func setUp() {
        super.setUp()
        apiService = APIService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }

    func testFetchProductsFromAPI() async throws {
        do {
            let products = try await apiService.fetchProducts()
            XCTAssertFalse(products.isEmpty)
            if let firstProduct = products.first {
                XCTAssertNotNil(firstProduct.id)
            }
        } catch {
            XCTFail("Fetching products failed with error: \(error.localizedDescription)")
        }
    }

    func testFetchProductsWithInvalidURL() async throws {
        do {
            let products = try await apiService.fetchProducts(urlString: "this-is-an-invalid-url")
            XCTFail("Expected to throw an invalidURL error but succeeded instead.")
        } catch let error as GSError {
            XCTAssertEqual(error, GSError.invalidURL)
        } catch {
            XCTFail("Fetching products failed with error: \(error.localizedDescription)")
        }
    }

    func testFetchProductsWithInvalidResponse() async throws {
        do {
            let products = try await apiService.fetchProducts(urlString: "https://random.com/expect-invalid-response")
            XCTFail("Expected to throw an invalidResponse error but succeeded instead.")
        } catch let error as GSError {
            XCTAssertEqual(error, GSError.invalidResponse)
        } catch {
            XCTFail("Fetching products failed with error: \(error.localizedDescription)")
        }
    }
}

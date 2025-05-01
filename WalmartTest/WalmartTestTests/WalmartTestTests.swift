//
//  WalmartTestTests.swift
//  WalmartTestTests
//
//  Created by D'Ante Watson on 4/30/25.
//

import XCTest
@testable @preconcurrency import WalmartTest

final class CountryListViewModelTests: XCTestCase {

    func testFetchCountriesSuccessUpdatesData() async {
        let mockService = MockCountryService()
        mockService.mockCountries = [
            Country(name: "USA", region: "NA", code: "US", capital: "Washington"),
            Country(name: "France", region: "EU", code: "FR", capital: "Paris")
        ]

        let viewModel = CountryListViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "onDataUpdate called")

        viewModel.onDataUpdate = {
            XCTAssertEqual(viewModel.numberOfCountries, 2)
            XCTAssertEqual(viewModel.country(at: 0).name, "USA")
            expectation.fulfill()
        }

        viewModel.fetchCountries()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testFetchCountriesFailureCallsOnError() async {
        let mockService = MockCountryService()
        mockService.shouldThrow = true

        let viewModel = CountryListViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "onError called")

        viewModel.onError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        viewModel.fetchCountries()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testFilterCountriesByName() async {
        let mockService = MockCountryService()
        mockService.mockCountries = [
            Country(name: "USA", region: "NA", code: "US", capital: "Washington"),
            Country(name: "France", region: "EU", code: "FR", capital: "Paris")
        ]

        let viewModel = CountryListViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "onDataUpdate called")

        viewModel.onDataUpdate = {
            DispatchQueue.main.async {
                viewModel.filter(with: "France")
                XCTAssertEqual(viewModel.numberOfCountries, 1)
                XCTAssertEqual(viewModel.country(at: 0).name, "France")
                expectation.fulfill()
            }
        }

        viewModel.fetchCountries()
        await fulfillment(of: [expectation], timeout: 1)
    }

}


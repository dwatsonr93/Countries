//
//  MockCountryService.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import Foundation

class MockCountryService: CountryServiceProtocol {
    var shouldThrow = false
    var mockCountries: [Country] = []

    func fetchCountries() async throws -> [Country] {
        if shouldThrow {
            throw NSError(domain: "MockError", code: 1)
        }
        return mockCountries
    }
}

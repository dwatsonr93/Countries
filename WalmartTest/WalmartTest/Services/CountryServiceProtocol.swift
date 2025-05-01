//
//  CountryServiceProtocol.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import Foundation

protocol CountryServiceProtocol {
    func fetchCountries() async throws -> [Country]
}

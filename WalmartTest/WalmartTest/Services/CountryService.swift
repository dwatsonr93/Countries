//
//  CountryService.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//
import Foundation

struct CountryService: CountryServiceProtocol {
    private let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"

    func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Country].self, from: data)
    }
}


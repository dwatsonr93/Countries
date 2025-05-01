//
//  Untitled.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import Foundation

class CountryListViewModel: CountryListViewModelProtocol {
    private let service: CountryServiceProtocol
    private var allCountries: [Country] = []
    private(set) var filteredCountries: [Country] = []

    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(service: CountryServiceProtocol) {
        self.service = service
    }

    func fetchCountries() {
        Task {
            do {
                let countries = try await service.fetchCountries()
                self.allCountries = countries
                self.filteredCountries = countries
                await MainActor.run { self.onDataUpdate?() }
            } catch {
                await MainActor.run { self.onError?(error) }
            }
        }
    }

    func filter(with query: String?) {
        guard let query = query?.lowercased(), !query.isEmpty else {
            filteredCountries = allCountries
            onDataUpdate?()
            return
        }
        filteredCountries = allCountries.filter {
            $0.name.lowercased().contains(query) ||
            $0.capital.lowercased().contains(query)
        }
        onDataUpdate?()
    }

    func country(at index: Int) -> Country {
        return filteredCountries[index]
    }

    var numberOfCountries: Int {
        return filteredCountries.count
    }
}

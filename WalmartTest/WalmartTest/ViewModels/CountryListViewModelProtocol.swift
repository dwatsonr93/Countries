//
//  CountryListViewModelProtocol.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import Foundation

protocol CountryListViewModelProtocol {
    var numberOfCountries: Int { get }
    var onDataUpdate: (() -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

    func fetchCountries()
    func filter(with query: String?)
    func country(at index: Int) -> Country
}

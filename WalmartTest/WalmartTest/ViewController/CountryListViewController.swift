//
//  Untitled.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import UIKit

class CountryListViewController: UITableViewController, UISearchResultsUpdating {

    private var viewModel: CountryListViewModelProtocol
    private let searchController = UISearchController(searchResultsController: nil)

    init(viewModel: CountryListViewModelProtocol = CountryListViewModel(service: CountryService())) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        setupTableView()
        setupSearchController()
        bindViewModel()
        viewModel.fetchCountries()
    }

    
    private func setupTableView() {
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name or capital"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] error in
            self?.showError(error)
        }
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCountries
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseIdentifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.country(at: indexPath.row))
        return cell
    }

    // MARK: - Search Updating
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filter(with: searchController.searchBar.text)
    }
}

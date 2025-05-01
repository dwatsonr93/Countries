//
//  CountryCell.swift
//  WalmartTest
//
//  Created by D'Ante Watson on 4/30/25.
//

import UIKit

class CountryCell: UITableViewCell {
    static let reuseIdentifier = "CountryCell"
    
    private let nameRegionLabel = UILabel()
    private let capitalLabel = UILabel()
    private let codeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameRegionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        capitalLabel.adjustsFontForContentSizeCategory = true
        codeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        codeLabel.adjustsFontForContentSizeCategory = true
        codeLabel.textAlignment = .right
        
        nameRegionLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameRegionLabel)
        contentView.addSubview(capitalLabel)
        contentView.addSubview(codeLabel)
        
        NSLayoutConstraint.activate([
            nameRegionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameRegionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameRegionLabel.trailingAnchor.constraint(equalTo: codeLabel.leadingAnchor, constant: -8),
            
            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            codeLabel.widthAnchor.constraint(equalToConstant: 40),
            
            capitalLabel.topAnchor.constraint(equalTo: nameRegionLabel.bottomAnchor, constant: 4),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            capitalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            capitalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with country: Country) {
        nameRegionLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}

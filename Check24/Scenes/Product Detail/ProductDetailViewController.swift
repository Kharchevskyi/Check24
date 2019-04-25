//
//  ProductDetailViewController.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol ProductDetailViewControllerInput {
    func update(with product: ProductOverviewViewModel)
}

protocol ProductDetailViewControllerOutput {
    func setup()
    func addToFavourite()
}

// MARK: - Implementation

class ProductDetailViewController: UITableViewController {
    enum Rows: CaseIterable {
        case image, shortDescription, description
    }

    var output: ProductDetailViewControllerOutput?
    private var product: ProductOverviewViewModel?

    private let rows = Rows.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        output?.setup()
    }

    private func setupUI() {
        tableView.tableHeaderView = nil
        tableView.register(cellType: ProductDetailImageCell.self)
        tableView.register(cellType: ProductDetailButtonCell.self)
        tableView.register(cellType: ProductDetailDescriptionCell.self)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product == nil ? 0 : rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = rows[safe: indexPath.row], let product = product else { fatalError("no cell provided in \(self.debugDescription)") }
        switch row {
        case .image:
            return tableView.dequeueReusableCell(ofType: ProductDetailImageCell.self, at: indexPath)
                .setup(with: product)
        case .shortDescription:
            return tableView.dequeueReusableCell(ofType: ProductDetailButtonCell.self, at: indexPath)
                .setup(with: product)
                .onTap { [weak self] in
                    self?.output?.addToFavourite()
                }
        case .description:
            return tableView.dequeueReusableCell(ofType: ProductDetailDescriptionCell.self, at: indexPath)
                .setup(with: product)
        }
    }
}

extension ProductDetailViewController: ProductDetailViewControllerInput {
    func update(with product: ProductOverviewViewModel) {
        self.product = product
        DispatchQueue.main.async {
             self.tableView.reloadData()
        }
    }
}
 

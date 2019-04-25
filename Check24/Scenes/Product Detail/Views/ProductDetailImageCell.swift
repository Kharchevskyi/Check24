//
//  ProductDetailImageCell.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

protocol ProductDetailCell {
    func setup(with viewModel: ProductOverviewViewModel) -> Self
}

final class ProductDetailImageCell: UITableViewCell, ProductDetailCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!


    func setup(with viewModel: ProductOverviewViewModel) -> ProductDetailImageCell {

        productImageView.backgroundColor = viewModel.backgroundColor
        productImageView.loadImageAsync(with: viewModel.imageURL)
        nameLabel.attributedText = viewModel.title
        priceLabel.attributedText = viewModel.price
        dateLabel.attributedText = viewModel.date

        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        productImageView.image = nil
        nameLabel.attributedText = nil
        priceLabel.attributedText = nil
        dateLabel.attributedText = nil
    }

}

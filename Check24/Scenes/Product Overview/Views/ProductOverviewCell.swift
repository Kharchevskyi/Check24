//
//  ProductOverviewCell.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

final class ProductOverviewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!

    @discardableResult
    func setup(with viewModel: ProductOverviewViewModel) -> ProductOverviewCell {

        backgroundColor = viewModel.backgroundColor
        imageView.loadImageAsync(with: viewModel.imageURL)
        nameLabel.attributedText = viewModel.title
        dateLabel.attributedText = viewModel.date
        descriptionLabel.attributedText = viewModel.description
        priceLabel.attributedText = viewModel.price

        // TODO: - ratingView
        // ratingView

        return self
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        nameLabel.attributedText = nil
        dateLabel.attributedText = nil
        descriptionLabel.attributedText = nil
        priceLabel.attributedText = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
    }
}


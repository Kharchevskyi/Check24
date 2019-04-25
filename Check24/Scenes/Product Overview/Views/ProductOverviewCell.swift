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

        imageView.backgroundColor = .red
        nameLabel.attributedText = viewModel.title
        dateLabel.attributedText = viewModel.date
        descriptionLabel.attributedText = viewModel.description
        priceLabel.attributedText = viewModel.price
//        ratingView.attributedText = viewModel.rating

        return self
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}


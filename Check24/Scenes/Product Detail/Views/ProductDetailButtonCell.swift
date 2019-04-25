//
//  ProductDetailButtonCell.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

class ProductDetailButtonCell: UITableViewCell {

    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productButton: UIButton!
    private var onTapAction: (() -> Void)?

    func setup(with viewModel: ProductOverviewViewModel) -> ProductDetailButtonCell {

        productButton.backgroundColor = Constants.Colors.mainColor
        productButton.setTitle("Add", for: .normal)
        productDescriptionLabel.attributedText = viewModel.description
        productDescriptionLabel.attributedText = viewModel.description
        
        return self
    }

    @IBAction func buttonAction(_ sender: Any) {
        onTapAction?()
    }

    func onTap(_ block: (() -> Void)?) -> ProductDetailButtonCell {
        self.onTapAction = block
        return self
    }

}

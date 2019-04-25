//
//  ProductDetailDescriptionCell.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

class ProductDetailDescriptionCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    func setup(with viewModel: ProductOverviewViewModel) -> ProductDetailDescriptionCell {
        label.attributedText = viewModel.longDescription
        return self
    }
    
}

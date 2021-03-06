//
//  ProductOverviewViewModel.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

struct ProductOverviewViewModel {
    let id: Int
    let imageURL: String?
    let title: NSAttributedString
    let date: NSAttributedString
    let description: NSAttributedString
    let longDescription: NSAttributedString
    let price: NSAttributedString
    let rating: Double
    let backgroundColor: UIColor
    let isAvailable: Bool
}

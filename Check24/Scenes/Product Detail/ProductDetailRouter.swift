//
//  ProductDetailRouter.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol ProductDetailRouting {
    
}

// MARK: - Implementation

final class ProductDetailRouter {
    private weak var viewController: ProductDetailViewController?

    init(viewController: ProductDetailViewController) {
        self.viewController = viewController
    }
}

extension ProductDetailRouter: ProductDetailRouting {
    
}

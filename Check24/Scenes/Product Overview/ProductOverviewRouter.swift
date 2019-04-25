//
//  ProductOverviewRouter.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol ProductOverviewRouting {
    
}

// MARK: - Implementation

final class ProductOverviewRouter {
    private weak var viewController: ProductOverviewViewController?

    init(viewController: ProductOverviewViewController) {
        self.viewController = viewController
    }
}

extension ProductOverviewRouter: ProductOverviewRouting {
    
}

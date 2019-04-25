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
    func show(scene: ProductOverviewRouter.Scene)
}

// MARK: - Implementation

final class ProductOverviewRouter {
    enum Scene {
        case productDetail(ProductOverviewViewModel)
    }

    private weak var viewController: ProductOverviewViewController?

    init(viewController: ProductOverviewViewController) {
        self.viewController = viewController
    }
}

extension ProductOverviewRouter: ProductOverviewRouting {
    func show(scene: ProductOverviewRouter.Scene) {
        switch scene {
        case .productDetail(let product):
            DispatchQueue.main.async {
                let scene = ProductDetailConfigurator.scene(with: product)
                self.viewController?.navigationController?.pushViewController(scene, animated: true)
            }
        }
    }
}

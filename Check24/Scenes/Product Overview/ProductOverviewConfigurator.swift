//
//  ProductOverviewConfigurator.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

extension ProductOverviewViewController: ProductOverviewPresenterOutput { }
extension ProductOverviewInteractor: ProductOverviewViewControllerOutput { }
extension ProductOverviewPresenter: ProductOverviewInteractorOutput { }

struct ProductOverviewConfigurator {
    static func scene() -> ProductOverviewViewController {
        let viewController = ProductOverviewViewController()
        let router = ProductOverviewRouter(viewController: viewController)
        let presenter = ProductOverviewPresenter(output: viewController, router: router)
        let interactor = ProductOverviewInteractor(
            output: presenter,
            api: NetworkingApi.default,
            imageCache: ImageCacheImpl.shared
        )
        viewController.output = interactor
        return viewController
    }
}

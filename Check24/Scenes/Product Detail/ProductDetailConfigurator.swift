//
//  ProductDetailConfigurator.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

extension ProductDetailViewController: ProductDetailPresenterOutput { }
extension ProductDetailInteractor: ProductDetailViewControllerOutput { }
extension ProductDetailPresenter: ProductDetailInteractorOutput { }

struct ProductDetailConfigurator {
    static func scene(with product: ProductOverviewViewModel) -> ProductDetailViewController {
        let viewController = ProductDetailViewController(style: .grouped)
        let router = ProductDetailRouter(viewController: viewController)
        let presenter = ProductDetailPresenter(output: viewController, router: router)
        let interactor = ProductDetailInteractor(output: presenter, product: product)
        viewController.output = interactor
        return viewController
    }
}

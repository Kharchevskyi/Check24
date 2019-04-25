//
//  ProductDetailPresenter.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol ProductDetailPresenterInput: class {
    func update(with product: ProductOverviewViewModel)
}

protocol ProductDetailPresenterOutput: class {
    func update(with product: ProductOverviewViewModel)
}

// MARK: - Implementation

final class ProductDetailPresenter {
    private weak var output: ProductDetailPresenterOutput?
    private let router: ProductDetailRouting

    init(output: ProductDetailPresenterOutput, router: ProductDetailRouting) {
        self.output = output
        self.router = router
    }
}

extension ProductDetailPresenter: ProductDetailPresenterInput {
    func update(with product: ProductOverviewViewModel) {
        output?.update(with: product)
    }
}

//
//  ProductOverviewPresenter.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol ProductOverviewPresenterInput: class {

}

protocol ProductOverviewPresenterOutput: class {

}

// MARK: - Implementation

final class ProductOverviewPresenter {
    private weak var output: ProductOverviewPresenterOutput?
    private let router: ProductOverviewRouting

    init(output: ProductOverviewPresenterOutput, router: ProductOverviewRouting) {
        self.output = output
        self.router = router
    }
}

extension ProductOverviewPresenter: ProductOverviewPresenterInput {

}

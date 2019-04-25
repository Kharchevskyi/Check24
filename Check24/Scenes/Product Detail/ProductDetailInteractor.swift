//
//  ProductDetailInteractor.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol ProductDetailInteractorInput {
    func setup()
    func addToFavourite()
}

protocol ProductDetailInteractorOutput {
    func update(with product: ProductOverviewViewModel)
}

// MARK: - Implementation

final class ProductDetailInteractor {
    private let product: ProductOverviewViewModel
    private let output: ProductDetailInteractorOutput
    private let favService: FavouriteCacheService = FavouriteCacheService()

    init(output: ProductDetailInteractorOutput, product: ProductOverviewViewModel) {
        self.output = output
        self.product = product
    }
}

extension ProductDetailInteractor: ProductDetailInteractorInput {
    func setup() {
        output.update(with: product)
    }

    func addToFavourite() {
        if favService.isFavourite(with: product.id) {
            favService.addToFavourite(with: product.id)
        } else {
            favService.removeFromFavourite(with: product.id)
        }
    }
}

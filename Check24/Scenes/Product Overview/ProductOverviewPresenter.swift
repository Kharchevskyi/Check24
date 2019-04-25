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
    func update(state newState: ProductOverviewInteractor.State)
}

protocol ProductOverviewPresenterOutput: class {
    func update(state newState: ProductOverviewViewController.State)
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
    func update(state newState: ProductOverviewInteractor.State) {
        output?.update(state: ProductOverviewViewController.State(newState))
    }
}

// MARK: - Mapping

extension ProductOverviewViewController.State {
    init(_ interactorState: ProductOverviewInteractor.State) {
        switch interactorState {
        case .idle: self = .idle
        case .loading(let isInitial): self = .loading(isInitial)
        case .loaded(let products): self = .loaded(products.map(ProductOverviewViewModel.init))
        case .failed(let error): self = .failed(error.localizedDescription) // TODO: provide descriptions for api errors
        }
    }
}

extension ProductOverviewViewModel {
    init(_ model: Product) {

    }
} 

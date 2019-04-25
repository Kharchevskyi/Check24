//
//  ProductOverviewInteractor.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol ProductOverviewInteractorInput {
    func handle(action: ProductOverviewInteractor.Action)
}

protocol ProductOverviewInteractorOutput {
    func update(state newState: ProductOverviewInteractor.State)
    func proceed(to scene: ProductOverviewRouter.Scene)
}

// MARK: - Implementation

final class ProductOverviewInteractor {
    enum Action {
        case setup, reload, dispose, proceedToDetails(Int)
    }

    enum State {
        case idle
        case loading(_ isInitial: Bool)
        case loaded([Product])
        case failed(APIError)
    }

    private let output: ProductOverviewInteractorOutput
    private let api: NetworkingApiType
    private let imageCache: ImageCache

    private var state: State = .idle {
        didSet {
            output.update(state: state)
        }
    }
    
    init(output: ProductOverviewInteractorOutput, api: NetworkingApiType, imageCache: ImageCache) {
        self.output = output
        self.api = api
        self.imageCache = imageCache
    }
}

extension ProductOverviewInteractor: ProductOverviewInteractorInput {
    func handle(action: ProductOverviewInteractor.Action) {
        switch action {
        case .setup: setup()
        case .reload: reload()
        case .dispose: dispose()
        case .proceedToDetails(let id): procceToDetail(with: id)
        }
    }

    private func setup() {
        // perform any initial tasks
        state = .loading(true)
        getProducts(isInitial: true)
    }

    private func reload() {
        state = .loading(false)
        getProducts(isInitial: false)
    }

    private func dispose() {
        api.dispose()
        imageCache.clear()
    }

    private func getProducts(isInitial: Bool) {
        api.getProducts(ProductsRequest()) { result in
            switch result {
            case .failure(let error):
                self.state = .failed(error)
            case .success(let items):
                self.state = .loaded(items)
            }
        }
    }

    private func procceToDetail(with id: Int) {
        guard case let .loaded(items) = state else { return }
        guard let product = items.first(where: { $0.id == id }) else { return }

        output.proceed(to: ProductOverviewRouter.Scene.productDetail(ProductOverviewViewModel(product)))
    }
}

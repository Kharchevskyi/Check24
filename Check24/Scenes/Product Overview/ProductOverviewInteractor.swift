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
        case setup, reload, dispose, proceedToDetails(Int), filter(ProductFilterType)
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
    private let favService: FavouriteCacheService
    private let queue = DispatchQueue(label: "com.interactor.queue", qos: DispatchQoS.background)
    private var state: State = .idle {
        didSet {
            output.update(state: state)
        }
    }
    
    init(output: ProductOverviewInteractorOutput, api: NetworkingApiType, imageCache: ImageCache, favService: FavouriteCacheService) {
        self.output = output
        self.api = api
        self.imageCache = imageCache
        self.favService = favService
    }
}

extension ProductOverviewInteractor: ProductOverviewInteractorInput {
    func handle(action: ProductOverviewInteractor.Action) {
        switch action {
        case .setup: setup()
        case .reload: reload()
        case .dispose: dispose()
        case .proceedToDetails(let id): procceToDetail(with: id)
        case .filter(let filter): filterProducts(with: filter)
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

    private func filterProducts(with filter: ProductFilterType) {
        guard case let .loaded(items) = state else { return }

        queue.sync {
            switch filter {
            case .all:
                output.update(state: .loaded(items))
            case .available:
                let filtered = items.filter { $0.available }
                output.update(state: .loaded(filtered))
            case .favorites:
                // get all products which are favourite from service
                break
                //            let filtered = items.filter { $0.isFavorite }
                //            output.update(state: .loaded(filtered))
            }
        }
    }
}

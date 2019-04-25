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

}

// MARK: - Implementation

final class ProductOverviewInteractor {
    enum Action {
        case setup, reload, dispose
    }

    private let output: ProductOverviewInteractorOutput

    init(output: ProductOverviewInteractorOutput) {
        self.output = output
    }
}

extension ProductOverviewInteractor: ProductOverviewInteractorInput {
    func handle(action: ProductOverviewInteractor.Action) {
        switch action {
        case .setup: setup()
        case .reload: reload()
        case .dispose: dispose()
        }
    }

    private func setup() {
        // perform any initial tasks here (i.e. data loading, passing existing data, etc.)
        // and pass results to the output (i.e. `output.refreshUsers(with: users)`)
    }

    private func reload() {

    }

    private func dispose() {
        
    }
}

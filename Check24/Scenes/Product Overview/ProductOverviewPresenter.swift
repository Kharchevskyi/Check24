//
//  ProductOverviewPresenter.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol ProductOverviewPresenterInput: class {
    func update(state newState: ProductOverviewInteractor.State)
    func proceed(to scene: ProductOverviewRouter.Scene)
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

    func proceed(to scene: ProductOverviewRouter.Scene) {
        router.show(scene: scene)
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
        self.id = model.id
        self.imageURL = model.imageURL
        self.date = ProductOverviewViewModel.date(from: model.releaseDate)
        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let descriptionAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]

        self.longDescription = NSAttributedString(
            string: model.longDescription,
            attributes: descriptionAttributes
        )

        self.title = NSAttributedString(
            string: model.name,
            attributes: titleAttributes
        )
        
        self.description = NSAttributedString(
            string: model.description,
            attributes: descriptionAttributes
        )
        self.price = ProductOverviewViewModel.price(from: model.price)
        self.rating = model.rating
        self.backgroundColor = UIColor.hexColor(model.colorCode)
        self.isAvailable = model.available
    }

    private static func date(from releaseDate: Double) -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: releaseDate))

        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        return NSAttributedString(string: dateString, attributes: attributes)
    }

    private static func price(from modelPrice: Price) -> NSAttributedString {
        let priceTitleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        let priceAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencyCode = modelPrice.currency
        
        let result = NSMutableAttributedString(
            string: NSLocalizedString("price: ".capitalized, comment: ""),
            attributes: priceTitleAttributes
        )

        let price = formatter.string(from: NSNumber(value: modelPrice.value))
            ?? String(modelPrice.value) + modelPrice.currency

        let priceString = NSAttributedString(
            string: price,
            attributes: priceAttributes
        )

        result.append(priceString)

        return result
    }

}

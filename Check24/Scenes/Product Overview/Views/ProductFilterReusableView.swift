//
//  ProductFilterReusableView.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

enum ProductFilterType: Int, CaseIterable {
    case all, available, favorites
    var title: String {
        switch self {
        case .all: return "All"
        case .available: return "Available"
        case .favorites: return "Favorite"
        }
    }

}

struct ProductFilter {
    static let allFilters = ProductFilterType
        .allCases
        .map { ProductFilter(title: $0.title, filterType: $0) }

    let title: String
    let filterType: ProductFilterType
}

final class ProductFilterView: UIView {
    typealias TapCompletion = (ProductFilterType) -> Void

    private var filters: [ProductFilter] = []
    private let stackView = UIStackView()
    private var onTapCompletion: TapCompletion?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        constrainToEdges(stackView, insets: UIEdgeInsets(top: 6, left: 32, bottom: 6, right: 32))
    }

    @discardableResult
    func setup(with filters: [ProductFilter], onTap: TapCompletion?) -> ProductFilterView {
        self.filters = filters
        self.onTapCompletion = onTap

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        filters.forEach { filter in
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = filter.filterType.rawValue
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(.black, for: .normal)
            button.setTitle(filter.title, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        }

        return self
    }

    @objc private func onButtonTap(_ sender: UIButton) {
        guard let filter = ProductFilterType(rawValue: sender.tag) else { return }
        onTapCompletion?(filter)
    }
}

//
//  ProductOverviewViewController.swift
//  Check24
//
//  Created by Anton Kharchevskyi on 4/25/19.
//  Copyright © 2019 Anton Kharchevskyi. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol ProductOverviewViewControllerInput {
    func update(state newState: ProductOverviewViewController.State)
}

protocol ProductOverviewViewControllerOutput {
    func handle(action: ProductOverviewInteractor.Action)
}

// MARK: - Implementation

final class ProductOverviewViewController: UIViewController {
    enum LocalConstants {
        static let filterHeight: CGFloat = 40
        static let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let minimumInteritemSpacing: CGFloat = 6
        static let cellHeight: CGFloat = 140
    }

    enum State {
        case idle, loading(Bool), loaded([ProductOverviewViewModel]), failed(String)
    }

    var output: ProductOverviewViewControllerOutput?

    private var state = State.idle
    private let refreshControl = UIRefreshControl()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let filterView = ProductFilterView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationController()
        output?.handle(action: .setup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        output?.handle(action: .dispose)
    }
}

extension ProductOverviewViewController {
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(collectionView)
        view.addSubview(filterView)

        setupCollectionView()
        setupFilterView()

        let guide = view.safeAreaLayoutGuide
        let constraints: [NSLayoutConstraint] = [
            filterView.topAnchor.constraint(equalTo: guide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            filterView.heightAnchor.constraint(equalToConstant: LocalConstants.filterHeight),
            collectionView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.addSubview(refreshControl)
        collectionView.register(cellType: ProductOverviewCell.self)

        // refresh control
        refreshControl.addTarget(
            self,
            action: #selector(refresh(_:)),
            for: .valueChanged
        )
        refreshControl.tintColor = .mainColor
    }

    private func setupFilterView() {
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.backgroundColor = .darkGray
        filterView.setup(with: ProductFilter.allFilters) { [weak self] filter in
            self?.output?.handle(action: .filter(filter))
        }
    }

    private func setupNavigationController() {
        let textColor = UIColor.white
        title = Constants.Global.applicationName
        navigationController?.navigationBar.tintColor = textColor
        navigationController?.navigationBar.barTintColor = Constants.Colors.mainColor

        let textAttributes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension ProductOverviewViewController {
    @objc private func refresh(_ sender: UIRefreshControl) {
        output?.handle(action: .reload)
    }

    private func endRefreshing() {
        guard refreshControl.isRefreshing else { return }
        refreshControl.endRefreshing()
    }
}

extension ProductOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .loaded(let items): return items.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch state {
        case .loaded(let items):
            guard let item = items[safe: indexPath.row] else {
                fatalError("no cell provided")
            }

            return collectionView.dequeueReusableCell(ofType: ProductOverviewCell.self, at: indexPath) 
                .setup(with: item)
        default:
            fatalError("no cell provided")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let .loaded(products) = state,
            let id = products[safe: indexPath.row]?.id
        else { return }
        output?.handle(action: .proceedToDetails(id))
    }
}

extension ProductOverviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch state {
        case .loaded:
            let width = collectionView.frame.size.width
                - LocalConstants.minimumInteritemSpacing * 2
                - LocalConstants.insets.left
                - LocalConstants.insets.right

            return CGSize(
                width: width,
                height: LocalConstants.cellHeight
            )
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return LocalConstants.insets
    }
}

extension ProductOverviewViewController: ProductOverviewViewControllerInput {
    func update(state newState: ProductOverviewViewController.State) {
        // TODO: - probably better to write some state machine for this
        state = newState

        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.endRefreshing()
        }
    }
}

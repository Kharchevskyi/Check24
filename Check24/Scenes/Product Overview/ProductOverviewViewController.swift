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
    enum State {
        case idle, loading, loaded, failed
    }

    var output: ProductOverviewViewControllerOutput?

    private var state = State.idle
    private let refreshControl = UIRefreshControl()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.addSubview(refreshControl)
        collectionView.constraintsToEdges(to: view.safeAreaLayoutGuide)

        refreshControl.addTarget(
            self,
            action: #selector(refresh(_:)),
            for: .valueChanged
        )
        refreshControl.tintColor = .mainColor
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
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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

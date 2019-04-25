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

}

protocol ProductOverviewViewControllerOutput {
    func handle(action: ProductOverviewInteractor.Action)
}

// MARK: - Implementation

final class ProductOverviewViewController: UIViewController {
    var output: ProductOverviewViewControllerOutput?

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

        collectionView.constraintsToEdges(to: view.safeAreaLayoutGuide)
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

extension ProductOverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ProductOverviewViewController: ProductOverviewViewControllerInput {

}

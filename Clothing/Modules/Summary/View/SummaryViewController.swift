//
//  SummaryViewController.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    var eventHandler: SummaryModuleInterface?

    var products: [SummaryProduct] = []

    lazy var configuration: URLSessionConfiguration = {
        $0.allowsCellularAccess = true
        $0.urlCache = nil
        return $0
    }(URLSessionConfiguration.ephemeral)

    lazy var downloader: NetworkDownloader = {
        return NetworkDownloader(configuration: self.configuration)
    }()

    var mainView: SummaryView {
        return view as! SummaryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler?.updateView()
    }

    func configureView() {
        self.title = "Clothing"

        self.mainView.collectionView.delegate = self
        self.mainView.collectionView.dataSource = self
        self.mainView.collectionView.prefetchDataSource = self
    }
}

// MARK: - SummaryViewInterface
extension SummaryViewController: SummaryViewInterface {

    func showError() {

    }

    func showDisplay(with data: [SummaryProduct]) {
        self.products = data
        self.reloadEntries()
    }

    func reloadEntries() {
        self.mainView.collectionView.reloadData()
    }
}

// MARK: - Collection view data source
extension SummaryViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.products.count == 0 {
            return 0
        } else {
            return self.products.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellID", for: indexPath) as! SummaryCollectionViewCell
        return cell
    }
}

// MARK: - Collection view delegate 
extension SummaryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let cell = cell as? SummaryCollectionViewCell else {
            fatalError("Error with register cell")
        }

        let product = self.products[indexPath.row]

        cell.productNameTextLabel?.text = product.name
        cell.priceTextLabel?.text = product.currencyAmount
        cell.imageView?.image = product.image

        if product.task == nil && product.image == nil {
            cell.indicator?.startAnimating()
            self.collectionView(collectionView, prefetchItemsAt: [indexPath])
        } else {
            cell.indicator?.stopAnimating()
        }
    }
}

// MARK: - Collection view data source prefetching
extension SummaryViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {

            let product = self.products[indexPath.row]

            guard product.image == nil else {
                return
            }

            guard product.task == nil else {
                return
            }
            
            guard let url = URL(string: product.imageURL) else {
                return
            }
            product.task = self.downloader.download(url) { url in
                product.task = nil
                if let url = url, let data = try? Data(contentsOf: url) {
                    product.image = UIImage(data: data)
                    collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
}


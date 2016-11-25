//
//  SummaryListViewController.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import AVFoundation

class SummaryListViewController: UIViewController {

    var mainView: SummaryListView {
        return view as! SummaryListView
    }

    var eventHandler: SummaryListModuleInterface?
    var products: [SummaryProduct] = []
    var indexRow: Int!

    lazy var configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.urlCache = nil
        return config
    }()

    lazy var downloader: NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .clothing
        self.configureApplicationShortcutItem()
        self.configureDataSourceDelegate()
        self.configure3DTouch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler?.updateView()
    }

    func configureApplicationShortcutItem() {
        let shortcut = UIApplicationShortcutItem(type: .homeType, localizedTitle: .home, localizedSubtitle: .summaryList, icon: UIApplicationShortcutIcon(type: .home), userInfo: nil)
        UIApplication.shared.shortcutItems = [shortcut]
    }
    
    func configureDataSourceDelegate() {
        self.mainView.collectionView.delegate = self
        self.mainView.collectionView.dataSource = self
        self.mainView.collectionView.prefetchDataSource = self
        if let layout = self.mainView.collectionView.collectionViewLayout as? SummaryListCollectionViewLayout {
            layout.delegate = self
        }
    }
    
    func configure3DTouch() {
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.mainView.collectionView)
        }
    }
    
}
// MARK: - SummaryListViewInterface
extension SummaryListViewController: SummaryListViewInterface {

    func showError() {
        self.eventHandler?.requestAlert()
    }

    func showDisplay(_ data: [SummaryProduct]) {
        self.products = data
        self.reloadEntries()
    }

    func reloadEntries() {
        self.mainView.collectionView.reloadData()
    }
    
    func reloadCellAtItem(_ data: [SummaryProduct]) {
        self.products = data
        let indexPath = IndexPath(item: self.indexRow, section: 0)
        self.mainView.collectionView.reloadItems(at: [indexPath])
    }
    
    //func reloadCellAtItem(_ data: Data) {
    //
    //}
        
}
// MARK: - Collection view cell delegate
extension SummaryListViewController: SummaryListCollectionViewCellDelegate {
    
    func updateFavourite(_ indexRow: Int, _ productID: NSNumber, _ favouriteSelected: Bool) {
        self.indexRow = indexRow
        self.eventHandler?.updateLatestView(productID, favouriteSelected)
    }
    
}
// MARK: - Collection view data source
extension SummaryListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.products.count != 0 else {
            return 0
        }
        return self.products.count 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .collectionViewCellID, for: indexPath) as! SummaryListCollectionViewCell
        return cell
    }
    
}
// MARK: - Collection view delegate 
extension SummaryListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? SummaryListCollectionViewCell else {
            fatalError("Error with register cell")
        }
        let product = self.products[indexPath.item]
        cell.configure(for: indexPath.item, product.id, product.name, product.currencyAmount, product.image, product.favouriteSelected)
        cell.delegate = self
        cell.isExclusiveTouch = true
        if product.task == nil && product.image == nil {
            cell.indicator?.startAnimating()
            self.collectionView(collectionView, prefetchItemsAt: [indexPath])
        } else {
            if product.image != nil {
                cell.indicator?.stopAnimating()
                cell.indicator?.hidesWhenStopped = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.item]
        self.eventHandler?.nextView(with: product)
    }
    /*
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let product = self.products[indexPath.item]

        if product.task == nil && product.image != nil {
            product.image = nil
        }
    }
    */
    
}
// MARK: - Collection view data source prefetching
extension SummaryListViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let product = self.products[indexPath.item]
            guard product.image == nil && product.task == nil else {
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
            //product.task = self.eventHandler?.updateCell(url) { data in
            //    product.task = nil
            //    product.image = UIImage(data: data)
            //    collectionView.reloadItems(at: [indexPath])
            //}
        }
    }
    
}
// MARK: - Collection view custom layout delegate 
extension SummaryListViewController: CollectionViewCellLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let defaultImageSize = CGSize(width: 150, height: 240)
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: defaultImageSize, insideRect: boundingRect)
        return rect.size.height
    }

    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let annotationPadding: CGFloat = 4.0
        let annotationHeaderHeight: CGFloat = 17.0
        let productNameHeight: CGFloat = 70.0
        let height = annotationHeaderHeight + productNameHeight + (annotationPadding * 2)
        return height
    }
    
}
// MARK:- 
extension SummaryListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = self.mainView.collectionView.indexPathForItem(at: location),
              let cell = self.mainView.collectionView.cellForItem(at: indexPath),
              let viewController = self.storyboard?.instantiateViewController(withIdentifier: .summaryDetailStoryboardID) as? SummaryDetailViewController  else {
            return nil
        }
        let product = self.products[indexPath.item]
        viewController.product = product
        viewController.preferredContentSize = CGSize(width: 0, height: 0)
        previewingContext.sourceRect = cell.frame
        return viewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        //self.showDetailViewController(viewControllerToCommit, sender: self)
        self.eventHandler?.nextView(with: viewControllerToCommit as! SummaryDetailViewController)
    }
    
}

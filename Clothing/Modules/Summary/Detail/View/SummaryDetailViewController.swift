//
//  SummaryDetailViewController.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailViewController: UIViewController {

    var eventHandler: SummaryDetailModuleInterface?
    
    var detailView: SummaryDetailView {
        return view as! SummaryDetailView
    }
    
    var product: SummaryProduct!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Translation.detail
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler?.updateView(withValue: self.product.id)
    }
    
    func configureView() {
        self.detailView.imageView.image = nil
        self.detailView.imageView.alpha = 0
        self.detailView.indicator.startAnimating()
    }

}

// MARK:- SummaryDetailViewInterface
extension SummaryDetailViewController: SummaryDetailViewInterface {
    
    func showDisplay(with data: Data) {
        let image = UIImage(data: data)
        self.detailView.imageView?.image = image
        self.detailView.indicator?.stopAnimating()
        self.detailView.indicator?.hidesWhenStopped = true
        self.reloadEntries()
    }
    
    func reloadEntries() {
        UIView.animate(withDuration: 0.3) {
            self.detailView.imageView.alpha = 1.0
        }
    }
    
}





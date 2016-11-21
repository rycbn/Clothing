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
    var product: SummaryProduct!
    var isPreviewing: Bool!
    
    var detailView: SummaryDetailView {
        return view as! SummaryDetailView
    }
    
    lazy var configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.urlCache = nil
        return config
    }()
    
    lazy var downloader : NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .detail
        if self.isPreviewing == true {
            self.configureViewIn3DTouch(withValue: self.product.id)
        } else {
            self.configureView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventHandler?.updateView(withValue: self.product.id)
    }
    
    func configureView() {
        self.animationStart()
    }

    func configureViewIn3DTouch(withValue value: NSNumber) {
        self.animationStart()
        
        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))
        
        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.downloader.download(url) { url in
            guard let url = url, let data = try? Data(contentsOf: url) else {
                return
            }
            self.animationStop(withData: data)
        }
    }
    
    func animationStart() {
        self.detailView.imageView.image = nil
        self.detailView.imageView.alpha = 0
        self.detailView.indicator.startAnimating()
    }
    
    func animationStop(withData data: Data) {
        let image = UIImage(data: data)
        self.detailView.imageView?.image = image
        self.detailView.indicator?.stopAnimating()
        self.detailView.indicator?.hidesWhenStopped = true
        
        UIView.animate(withDuration: 0.3) {
            self.detailView.imageView.alpha = 1.0
        }
    }
    
}

// MARK:- SummaryDetailViewInterface
extension SummaryDetailViewController: SummaryDetailViewInterface {
    
    func showDisplay(with data: Data) {
        self.animationStop(withData: data)
    }
    
}




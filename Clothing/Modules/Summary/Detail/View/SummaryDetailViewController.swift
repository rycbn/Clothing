//
//  SummaryDetailViewController.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailViewController: UIViewController {

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

    var product: SummaryProduct!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Translation.detail
        
        self.configureView(value: self.product.id)
    }
    
    func configureView(value: NSNumber) {
        
        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))
        
        self.detailView.imageView.image = nil
        self.detailView.imageView.alpha = 0
        self.detailView.indicator.startAnimating()
        
        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.downloader.download(url) { url in
            if let url = url, let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                self.detailView.imageView?.image = image
                self.detailView.indicator?.stopAnimating()
                self.detailView.indicator?.hidesWhenStopped = true
                
                UIView.animate(withDuration: 0.3) {
                    self.detailView.imageView.alpha = 1.0
                }
            }
        }
    }

}

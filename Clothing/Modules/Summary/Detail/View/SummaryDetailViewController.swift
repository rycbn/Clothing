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

    var product: SummaryProduct!

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
        self.title = Translation.detail
        self.configureView()
    }
    
    func configureView() {
        self.detailView.imageView.image = nil
        self.detailView.indicator.startAnimating()
        
        let value = self.product.id ?? 0
        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))

        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.downloader.download(url) { url in
            if let url = url, let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                self.detailView.imageView?.image = image
                self.detailView.indicator?.stopAnimating()
                self.detailView.indicator?.hidesWhenStopped = true
            }
        }
    }
}

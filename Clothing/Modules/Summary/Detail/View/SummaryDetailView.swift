//
//  SummaryDetailView.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    lazy var configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.urlCache = nil
        return config
    }()
    
    lazy var downloader : NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    func configure(value: NSNumber) {

        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))

        self.imageView.image = nil
        self.indicator.startAnimating()
        
        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.downloader.download(url) { url in
            if let url = url, let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                self.imageView?.image = image
                self.indicator?.stopAnimating()
                self.indicator?.hidesWhenStopped = true
            }
        }
    }
}

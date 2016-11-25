//
//  AsyncImageView.swift
//  Clothing
//
//  Created by Chau Boon Yong on 25/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

public class AsyncImageView: UIImageView {
    
    private lazy var configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.urlCache = nil
        return config
    }()
    
    private lazy var downloader : NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    public var placeholderImage: UIImage?
    public var indicator: UIActivityIndicatorView?
    
    public var url: URL? {
        didSet {
            self.indicator?.startAnimating()
            self.image = self.placeholderImage
            self.alpha = 0
            guard let url = url else {
                return
            }
            self.downloader.download(url) { [weak self] url in
                guard let strongSelf = self, let url = url, let data = try? Data(contentsOf: url)  else {
                    return
                }
                strongSelf.image = UIImage(data: data) ?? strongSelf.placeholderImage
                
                UIView.animate(withDuration: 0.3) {
                    strongSelf.alpha = 1
                    strongSelf.indicator?.stopAnimating()
                    strongSelf.indicator?.hidesWhenStopped = true
                }
            }
        }
    }
    
}

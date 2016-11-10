//
//  SummaryDetailDataManager.swift
//  Clothing
//
//  Created by Chau Boon Yong on 10/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryDetailDataManager {

    lazy var configuration : URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = true
        config.urlCache = nil
        return config
    }()
    
    lazy var downloader : NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    func fetchingImaga(withValue value: NSNumber, onComplete: @escaping (_ data: Data) -> Void) {
        
        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))
        
        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.downloader.download(url) { url in
            if let url = url, let data = try? Data(contentsOf: url) {
                onComplete(data)
            }
        }
    }
}

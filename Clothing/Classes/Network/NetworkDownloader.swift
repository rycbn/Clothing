//
//  NetworkDownloader.swift
//  Clothing
//
//  Created by Roger Yong on 17/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

//
//  NetworkDownloader.swift
//  Clothing
//
//  Created by Roger Yong on 17/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

let isMain = false // try false to move delegate methods onto a background thread

class NetworkDownloader: NSObject {

    typealias NetworkDownloaderCompletion = (URL?) -> ()

    let config: URLSessionConfiguration
    let queue = OperationQueue()

    lazy var session: URLSession = {
        let q = (isMain ? .main: self.queue)
        return URLSession(configuration: self.config, delegate: NetworkDownloader.NetworkDownloaderDelegate(), delegateQueue: q)
    }()

    init(configuration config: URLSessionConfiguration) {
        self.config = config
        super.init()
    }

    @discardableResult
    func download(_ url: URL, completionHandler ch: @escaping NetworkDownloaderCompletion) -> URLSessionTask {

        let request = NSMutableURLRequest(url: url)
        URLProtocol.setProperty(ch as Any, forKey: "ch", in: request)
        let task = self.session.downloadTask(with: request as URLRequest)
        task.resume()

        return task
    }

    private class NetworkDownloaderDelegate: NSObject, URLSessionDownloadDelegate {

        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo url: URL) {

            guard let request = downloadTask.originalRequest else {
                return
            }

            let ch = URLProtocol.property(forKey: "ch", in: request) as! NetworkDownloaderCompletion

            if isMain {
                ch(url)
            } else {
                DispatchQueue.main.sync {
                    ch(url)
                }
            }
        }

        deinit {
            print("farewell from Delegate")
        }
    }

    deinit {
        print("farewell from NetworkDownloader")
        self.session.invalidateAndCancel()
    }
    
}

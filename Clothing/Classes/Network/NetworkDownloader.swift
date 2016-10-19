//
//  NetworkDownloader.swift
//  Clothing
//
//  Created by Roger Yong on 17/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

let isMain = false // try false to move delegate methods onto a background thread

typealias NetworkDownloaderCompletion = (URL!) -> ()

class NetworkDownloader: NSObject {
    let config : URLSessionConfiguration
    let queue = OperationQueue()

    lazy var session : URLSession = {
        let queue = (isMain ? .main : self.queue)
        return URLSession(configuration:self.config, delegate:NetworkDownloaderDelegate(), delegateQueue:queue)
    }()

    init(configuration config:URLSessionConfiguration) {
        self.config = config
        super.init()
    }

    @discardableResult
    func download(_ url:URL, completionHandler ch : @escaping NetworkDownloaderCompletion) -> URLSessionTask {
        let req = NSMutableURLRequest(url:url)
        URLProtocol.setProperty(ch as Any, forKey:"ch", in:req)
        let task = self.session.downloadTask(with:req as URLRequest)
        task.resume()
        return task
    }

    private class NetworkDownloaderDelegate : NSObject, URLSessionDownloadDelegate {
        func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo url: URL) {
            let req = downloadTask.originalRequest!
            let ch = URLProtocol.property(forKey:"ch", in:req) as! NetworkDownloaderCompletion
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
        print("farewell from MyDownloader")
        self.session.invalidateAndCancel()
    }
    
}

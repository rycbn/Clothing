//
//  SummaryDetailViewController.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailViewController: UIViewController {

    var mainView: SummaryDetailView {
        return view as! SummaryDetailView
    }

    var product: SummaryProduct!

    lazy var configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsCellularAccess = false
        config.urlCache = nil
        return config
    }()

    lazy var downloader: NetworkDownloader = {
        return NetworkDownloader(configuration:self.configuration)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

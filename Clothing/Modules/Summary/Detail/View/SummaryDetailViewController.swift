//
//  SummaryDetailViewController.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailViewController: UIViewController {

    var product: SummaryProduct!
    
    var detailView: SummaryDetailView {
        return view as! SummaryDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .detail
        self.configureView(withValue: self.product.id)
    }

    func configureView(withValue value: NSNumber) {
        guard let value = self.product.id else {
            return
        }
        
        let detailImageURL = Utility.subtituteKey(in: APIKeys.detailImageURL, key: URLKeys.pid, value: String(describing: value))
        
        guard let url = URL(string: detailImageURL) else {
            return
        }
        
        self.detailView.configureImageViewFrom(url)
    }
}
    


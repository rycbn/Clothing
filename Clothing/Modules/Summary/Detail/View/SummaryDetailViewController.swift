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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Translation.detail
        self.detailView.configure(value: self.product.id)
    }
}

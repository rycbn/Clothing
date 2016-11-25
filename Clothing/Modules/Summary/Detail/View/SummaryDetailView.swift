//
//  SummaryDetailView.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryDetailView: UIView {

    @IBOutlet weak var imageView: AsyncImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.indicator = self.indicator
    }
    
    func configureImageViewFrom(_ url: URL) {
        self.imageView.url = url
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.imageView.alpha = 1
        }
    }

}

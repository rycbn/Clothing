//
//  SummaryCollectionViewCell.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameTextLabel: UILabel!
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//
//  SummaryCollectionViewCell.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameTextLabel: UILabel!
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewHeightlayoutConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? SummaryCollectionViewLayoutAttributes {
            imageViewHeightlayoutConstraint.constant = attributes.imageHeight
        }
    }

    func configure(for name: String, _ price: String, _ image: UIImage) {
        self.imageView.image = image.decompressedImage
        self.productNameTextLabel?.text = name
        self.priceTextLabel?.text = price
    }
}

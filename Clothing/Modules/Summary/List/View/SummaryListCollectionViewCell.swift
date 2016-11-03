//
//  SummaryListCollectionViewCell.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameTextLabel: UILabel!
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewHeightLayoutConstraints: NSLayoutConstraint!
    @IBOutlet weak var productNameTextView: UITextView! {
        didSet {
            self.productNameTextView?.textContainer.lineFragmentPadding = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? SummaryListCollectionViewLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            textViewHeightLayoutConstraints.constant = attributes.textHeight
        }
    }

    func configure(for name: String?, _ price: String?, _ image: UIImage?) {
        self.imageView?.image = image?.decompressedImage
        //self.productNameTextLabel?.text = name
        self.productNameTextView?.text = name
        self.priceTextLabel?.text = price
    }
}

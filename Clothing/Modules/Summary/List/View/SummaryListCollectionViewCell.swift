//
//  SummaryListCollectionViewCell.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

protocol SummaryListCollectionViewCellDelegate: class {
    func updateFavourite(_ indexRow: Int, _ productID: NSNumber, _ favouriteSelected: Bool)
}

class SummaryListCollectionViewCell: UICollectionViewCell {

    weak var delegate: SummaryListCollectionViewCellDelegate?
    var productID: NSNumber!
    var favouriteSelected: Bool!
    var indexRow: Int!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var textViewHeightLayoutConstraints: NSLayoutConstraint!
    @IBOutlet weak var productNameTextView: UITextView!
    @IBOutlet weak var heartButton: UIButton!

    @IBAction func favourited(_ sender: UIButton) {
        self.favouriteSelected = !self.favouriteSelected
        self.delegate?.updateFavourite(self.indexRow, self.productID, self.favouriteSelected)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.productNameTextView?.textContainer.lineFragmentPadding = 0
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? SummaryListCollectionViewLayoutAttributes {
            self.imageViewHeightLayoutConstraint.constant = attributes.imageHeight
            self.textViewHeightLayoutConstraints.constant = attributes.textHeight
        }
    }
    
    func configure(for indexRow: Int, _ id: NSNumber?, _ name: String?, _ price: String?, _ image: UIImage?, _ favourite: Bool?) {
        self.indexRow = indexRow
        self.productID = id
        self.productNameTextView?.text = name
        self.priceTextLabel?.text = price
        self.imageView?.image = image?.decompressedImage
        self.favouriteSelected = favourite
        
        if self.favouriteSelected == false {
            self.heartButton.setImage(#imageLiteral(resourceName: "heart_empty"), for: .normal)
        } else {
            self.heartButton.setImage(#imageLiteral(resourceName: "heart_filled"), for: .normal)
        }
    }
    
    
}

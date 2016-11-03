//
//  SummaryListCollectionViewLayoutAttributes.swift
//  Clothing
//
//  Created by Roger Yong on 20/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryListCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var imageHeight: CGFloat = 0.0
    var textHeight: CGFloat = 0.0

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! SummaryListCollectionViewLayoutAttributes
        copy.imageHeight = imageHeight
        copy.textHeight = textHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? SummaryListCollectionViewLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
            if attributes.textHeight == textHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

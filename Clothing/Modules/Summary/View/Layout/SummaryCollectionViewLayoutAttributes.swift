//
//  SummaryCollectionViewLayoutAttributes.swift
//  Clothing
//
//  Created by Roger Yong on 20/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var imageHeight: CGFloat = 270.0

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! SummaryCollectionViewLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? SummaryCollectionViewLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

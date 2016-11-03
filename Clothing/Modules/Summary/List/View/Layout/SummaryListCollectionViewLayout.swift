//
//  SummaryListCollectionViewLayout.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

protocol CollectionViewCellLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForImageAt indexPath: IndexPath, with width: CGFloat) -> CGFloat

    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAt indexPath: IndexPath, with width: CGFloat) -> CGFloat
}

class SummaryListCollectionViewLayout: UICollectionViewLayout {

    var delegate: CollectionViewCellLayoutDelegate!
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6

    private var cache = [SummaryListCollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0.0
    private var contentWidth: CGFloat {
        guard let insets = self.collectionView?.contentInset else {
            return 0.0
        }
        guard let width = self.collectionView?.bounds.width else {
            return 0.0
        }
        return width - (insets.left + insets.right)
    }

    override class var layoutAttributesClass: AnyClass {
        return SummaryListCollectionViewLayoutAttributes.self
    }

    override func prepare() {
        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

            guard let numberOfItemsInSection = self.collectionView?.numberOfItems(inSection: 0) else {
                return
            }
            guard let collectionView = self.collectionView else {
                return
            }

            for item in 0..<numberOfItemsInSection {
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth - (cellPadding * 2)
                let imageHeight = self.delegate.collectionView(collectionView, heightForImageAt: indexPath, with: width)
                let annotationHeight = self.delegate.collectionView(collectionView, heightForAnnotationAt: indexPath, with: width)
                let height = imageHeight + annotationHeight + (cellPadding * 2)
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = SummaryListCollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.imageHeight = imageHeight
                attributes.textHeight = 70.0
                attributes.frame = insetFrame
                cache.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height

                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
        }
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attribute in cache {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}

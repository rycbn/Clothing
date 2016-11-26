//
//  CollectionView.swift
//  Clothing
//
//  Created by Chau Boon Yong on 09/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

enum CollectionViewCellIdentifier: String {
    case collectionViewCellID
}

extension UICollectionView {
    
    func dequeueReusableCell(withReuseIdentifier identifier: CollectionViewCellIdentifier, for indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: identifier.rawValue, for: indexPath)
    }
    
    func register(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: CollectionViewCellIdentifier) {
        self.register(cellClass, forCellWithReuseIdentifier: identifier.rawValue)
    }
    
}

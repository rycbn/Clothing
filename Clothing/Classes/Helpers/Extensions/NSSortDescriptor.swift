//
//  NSSortDescriptor.swift
//  Clothing
//
//  Created by Chau Boon Yong on 14/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

enum SortDescription: String {
    case name
}

extension NSSortDescriptor {
    
    convenience init(key: SortDescription, ascending: Bool) {
        self.init(key: key.rawValue, ascending: ascending)
    }
    
}

//
//  EntityDescription.swift
//  Clothing
//
//  Created by Chau Boon Yong on 11/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

enum EntityName: String {
    case product
    case price
}

extension NSEntityDescription {

    class func entity(forEntityName entityName: EntityName, in context: NSManagedObjectContext) -> NSEntityDescription? {
        return self.entity(forEntityName: entityName.rawValue.capitalized, in: context)
    }
    
}

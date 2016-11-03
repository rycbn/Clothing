//
//  ManagedPrice.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

public class ManagedPrice: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPrice> {
        return NSFetchRequest<ManagedPrice>(entityName: "ManagedPrice");
    }

    @NSManaged public var currency: String?
    @NSManaged public var divisor: NSNumber?
    @NSManaged public var amount: NSNumber?
    @NSManaged public var product: ManagedProduct?

}

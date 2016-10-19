//
//  ManagedProduct.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

public class ManagedProduct: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProduct> {
        return NSFetchRequest<ManagedProduct>(entityName: "ManagedProduct");
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var favouriteSelected: Bool
    @NSManaged public var price: ManagedPrice?
    @NSManaged public var imageURL: String?

}

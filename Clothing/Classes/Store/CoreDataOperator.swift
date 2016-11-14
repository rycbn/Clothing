//
//  CoreDataOperator.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

class CoreDataOperator {

    class func objectCountForEntity(_ entityName: EntityName, context: NSManagedObjectContext) -> Int {
        let request = CoreDataOperator.fetchRequest(entityName)
        do {
            return try context.count(for: request)
        } catch {
            print("\(#function) Error: \(CoreDataError.request)")
            return 0
        }
    }

    class func objectForEntity(_ entityName: EntityName, context: NSManagedObjectContext, filter: NSPredicate?, sort:[NSSortDescriptor]?) -> [AnyObject]? {
        let request = CoreDataOperator.fetchRequest(entityName)
        request.predicate = filter
        request.sortDescriptors = sort
        do {
            return try context.fetch(request)
        } catch {
            print("\(#function) Error: \(CoreDataError.request)")
            return nil
        }
    }

    class func objectBatchDeletion(_ entityName: EntityName, context: NSManagedObjectContext) {
        let request = CoreDataOperator.fetchRequest(entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("\(#function) Error: \(CoreDataError.request)")
        }
    }

    class func fetchRequest(_ entityName: EntityName) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue.capitalized)
    }
    
}

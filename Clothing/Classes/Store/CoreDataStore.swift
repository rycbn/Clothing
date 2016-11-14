//
//  CoreDataStore.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case persistent
    case save
    case request
}

class CoreDataStore {

    static let modelName = "Clothing"

    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        $0.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard error == nil else {
                fatalError("Error: \(CoreDataError.persistent)")
            }
        })
        return $0
    }(NSPersistentContainer(name: CoreDataStore.modelName))

    fileprivate lazy var mainContext: NSManagedObjectContext = {
        $0.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return $0
    }(NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))

    lazy var privateContext: NSManagedObjectContext = {
        $0.parent = self.mainContext
        return $0
    }(NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType))

    func saveContext() {
        self.privateContext.performAndWait {
            if self.privateContext.hasChanges {
                do {
                    try self.privateContext.save()
                } catch {
                    print("Error: \(CoreDataError.save)")
                }
            }
        }
    }
    
}


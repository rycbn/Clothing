//
//  ListDataStoreConvenience.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import CoreData

extension CoreDataStore {

    func insertProduct(from entries: [AnyObject]) -> [Product] {
        self.deleteProduct()

        guard let entityProduct = NSEntityDescription.entity(forEntityName: CoreDataStore.EntityName.product, in: self.privateContext),
              let entityPrice = NSEntityDescription.entity(forEntityName: CoreDataStore.EntityName.price, in: self.privateContext) else {
            return [Product]()
        }

        for entry in entries {
            let product = ManagedProduct(entity: entityProduct, insertInto: self.privateContext)
            product.id = entry.value(forKey: JSONResponseKeys.id) as? NSNumber
            product.name = entry.value(forKey: JSONResponseKeys.name) as? String

            let price = ManagedPrice(entity: entityPrice, insertInto: self.privateContext)
            price.currency = entry.value(forKeyPath: JSONResponseKeyPaths.currency) as? String
            price.divisor = entry.value(forKeyPath: JSONResponseKeyPaths.divisor) as? NSNumber
            price.amount = entry.value(forKeyPath: JSONResponseKeyPaths.amount) as? NSNumber

            product.price = price
            let value = product.id ?? 0
            product.imageURL = Utility.subtituteKey(in: APIKeys.imageURL, key: URLKeys.pid, value: String(describing: value))

            self.saveContext()
        }

        let allProduct = self.allProduct()

        return allProduct
    }

    func allProduct() -> [Product] {
        let nameSort = NSSortDescriptor(key: JSONResponseKeys.name, ascending: true)
        let sort = [nameSort]
        let managedProduct = CoreDataOperator.objectForEntity(CoreDataStore.EntityName.product, context: self.privateContext, filter: nil, sort: sort) as! [ManagedProduct]

        return managedProduct.map { dictionary in
            return ProductParser.mapElement(dictionary)
        }
    }

    func deleteProduct() {
        let _ = CoreDataOperator.objectBatchDeletion(CoreDataStore.EntityName.product, context: self.privateContext)
        let _ = CoreDataOperator.objectBatchDeletion(CoreDataStore.EntityName.price, context: self.privateContext)
    }

    func countProduct() -> Int {
        let count = CoreDataOperator.objectCountForEntity(CoreDataStore.EntityName.product, context: self.privateContext)
        return count
    }
    
    func allLatestProduct(_ productID: NSNumber, _ favouriteSelected: Bool) -> [Product]? {
        let request = CoreDataOperator.fetchRequest(CoreDataStore.EntityName.product)
        request.predicate = NSPredicate(format: "%K = %@", JSONResponseKeys.id, productID)
        do {
            let results = try self.privateContext.fetch(request) as! [ManagedProduct]
            let item = results[0]
            item.favouriteSelected = favouriteSelected
            self.saveContext()
            
            let products = self.allProduct()
            
            return products
        }
        catch let error as NSError {
            print("Error: \(error)" + "description: \(error.localizedDescription)")
            return nil
        }
    }
}




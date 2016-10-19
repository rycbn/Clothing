//
//  SummaryDataStoreConvenience.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import CoreData

extension CoreDataStore {

    func insertProduct(from entries: [AnyObject]) -> [Product] {

        self.deleteProducts()

        guard
            let entityProduct = NSEntityDescription.entity(forEntityName: CoreDataStore.EntityName.product, in: self.privateContext),
            let entityPrice = NSEntityDescription.entity(forEntityName: CoreDataStore.EntityName.price, in: self.privateContext)
        else {
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

        let allProducts = self.allProducts()

        return allProducts
    }

    func allProducts() -> [Product] {

        let nameSort = NSSortDescriptor(key: JSONResponseKeys.name, ascending: true)
        let sort = [nameSort]
        let managedProduct = CoreDataOperator.objectForEntity(CoreDataStore.EntityName.product, context: self.privateContext, filter: nil, soft: sort) as! [ManagedProduct]

        return managedProduct.map { dictionary in
            return ProductParser.mapElement(dictionary)
        }
    }

    func deleteProducts() {

        _ = CoreDataOperator.objectBatchDeletion(CoreDataStore.EntityName.product, context: self.privateContext)
        _ = CoreDataOperator.objectBatchDeletion(CoreDataStore.EntityName.price, context: self.privateContext)

    }

}




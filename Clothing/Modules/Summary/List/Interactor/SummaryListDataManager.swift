//
//  SummaryListDataManager.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryListDataManager {

    var networkManager: NetworkManager?
    var coreDataStore: CoreDataStore?

    func loadSummaryList(onComplete: @escaping ([Product]?, Error?) -> Void) {
        self.networkManager?.loadingSummaryListFromAPI { [weak self] (results, error) in

            guard error == nil else {
                onComplete(nil, error)
                return
            }
            guard let results = results else {
                onComplete(nil, error)
                return
            }
            guard let items = results.value(forKey: JSONResponseKeys.summaries) as? [AnyObject] else {
                onComplete(nil, error)
                return
            }

            let products = self?.productFromDataStore(items)
            
            onComplete(products, error)
        }
    }

    func productFromDataStore(_ entries: [AnyObject]) -> [Product] {

        guard let products = self.coreDataStore?.insertProduct(from: entries) else {
            return [Product]()
        }
        return products
    }

    func productCountFromDataStore() -> Int {

        guard let count = self.coreDataStore?.countProduct() else {
            return 0
        }
        return count
    }

    func allProductFromDataStory() -> [Product] {

        guard let products = self.coreDataStore?.allProducts() else {
            return [Product]()
        }
        return products
    }
}



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
        self.networkManager?.loadingSummaryListFromAPI{ [weak self] (results) in
            switch results {
            case .onEror(let error):
                return onComplete(nil, error)
            case .onSuccess(let response):
                guard let items = response.value(forKey: JSONResponseKeys.summaries) as? [AnyObject] else {
                    return
                }
                let products = self?.productFromDataStore(items)
                onComplete(products, nil)
            }
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

    func allProductFromDataStore() -> [Product] {
        guard let products = self.coreDataStore?.allProduct() else {
            return [Product]()
        }
        return products
    }
    
    func allLatestProductFromDataStore(_ productID: NSNumber, _ favouriteSelected: Bool) -> [Product] {
        guard let products = self.coreDataStore?.allLatestProduct(productID, favouriteSelected) else {
            return [Product]()
        }
        return products
    }

}



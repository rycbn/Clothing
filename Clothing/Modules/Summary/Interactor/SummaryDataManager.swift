//
//  SummaryDataManager.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryDataManager {

    var networkManager: NetworkManager?
    var coreDataStore: CoreDataStore?

    func loadSummary(onComplete: @escaping ([Product]?, Error?) -> Void) {
        self.networkManager?.loadingSummaryFromAPI { [weak self] (results, error) in

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
}


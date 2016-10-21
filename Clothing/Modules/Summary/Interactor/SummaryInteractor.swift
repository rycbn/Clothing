//
//  SummaryInteractor.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryInteractor {

    var summaryInteractorOutput: SummaryInteractorOutput?

    let summaryDataManager: SummaryDataManager

    init(_ summaryDataManager: SummaryDataManager) {
        self.summaryDataManager = summaryDataManager
    }

    func upcomingItems(from products: [Product]?) -> [SummaryProduct] {
        guard let products = products else {
            return [SummaryProduct]()
        }
        let upcomingItems: [SummaryProduct] = products.map { product in
            let amount = Utility.getFormattedAmount(product.amount, product.divisor, product.currency)
            let sp = SummaryProduct()
            sp.id = product.id
            sp.name = product.name
            sp.favouriteSelected = product.favouriteSelected
            sp.currencyAmount = amount
            sp.imageURL = product.imageURL
            sp.indicator = nil
            sp.image = nil
            sp.task = nil
            return sp
        }
        return upcomingItems
    }
}
// MARK:- SummaryInteractorInput
extension SummaryInteractor: SummaryInteractorInput {
    func findSummary() {

        let productCount = self.summaryDataManager.productCountFromDataStore()

        if productCount == 0 {
            self.summaryDataManager.loadSummary { [weak self] (products, error) in
                let upcomingItems = self?.upcomingItems(from: products)
                self?.summaryInteractorOutput?.foundSummary(upcomingItems, error)
            }
        } else {
            let products = self.summaryDataManager.allProductFromDataStory()
            let upcommingItems = self.upcomingItems(from: products)
            self.summaryInteractorOutput?.foundSummary(upcommingItems, nil)
        }

    }
}

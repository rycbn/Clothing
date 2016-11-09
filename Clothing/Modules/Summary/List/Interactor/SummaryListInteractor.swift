//
//  SummaryListInteractor.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class SummaryListInteractor {

    var summaryListInteractorOutput: SummaryListInteractorOutput?

    let summaryListDataManager: SummaryListDataManager

    init(_ summaryListDataManager: SummaryListDataManager) {
        self.summaryListDataManager = summaryListDataManager
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
// MARK:- SummaryListInteractorInput
extension SummaryListInteractor: SummaryListInteractorInput {
    
    func findSummaryList() {

        let productCount = self.summaryListDataManager.productCountFromDataStore()

        if productCount == 0 {
            self.summaryListDataManager.loadSummaryList { [weak self] (products, error) in
                let upcomingItems = self?.upcomingItems(from: products)
                self?.summaryListInteractorOutput?.foundSummaryList(upcomingItems, error)
            }
        } else {
            let products = self.summaryListDataManager.allProductFromDataStore()
            let upcommingItems = self.upcomingItems(from: products)
            self.summaryListInteractorOutput?.foundSummaryList(upcommingItems, nil)
        }
    }
    
    func findLatestSummaryList(_ productID: NSNumber, _ favouriteSelected: Bool) {
        let products = self.summaryListDataManager.allLatestProductFromDataStore(productID, favouriteSelected)
        let upcommingItems = self.upcomingItems(from: products)
        self.summaryListInteractorOutput?.foundLatestSummaryList(upcommingItems)
    }
    
}

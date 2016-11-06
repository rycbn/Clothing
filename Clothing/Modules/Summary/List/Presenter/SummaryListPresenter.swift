//
//  SummaryListPresenter.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryListPresenter {

    var summaryListInteractorInput: SummaryListInteractorInput?
    var summaryListViewInterface: SummaryListViewInterface?
    var summaryListRouter: SummaryListRouter?

    func updateSummaryListViewInterface(with products: [SummaryProduct]) {
        self.summaryListViewInterface?.showDisplay(with: products)
    }
    
    func updateLatestSummaryListViewInterface(with products: [SummaryProduct]) {
        self.summaryListViewInterface?.reloadCellAtItemRow(with: products)
    }
}

// MARK: - SummaryListModuelInterface
extension SummaryListPresenter: SummaryListModuleInterface {
    
    func updateView() {
        self.summaryListInteractorInput?.findSummaryList()
    }

    func requestAlert() {
        self.summaryListRouter?.showAlert()
    }
    
    func nextView(with product: SummaryProduct) {
        self.summaryListRouter?.showSummaryDetailInterface(with: product)
    }
    
    func updateView(with productID: NSNumber, _ favouriteSelected: Bool) {
        self.summaryListInteractorInput?.findLatestSummaryList(with: productID, favouriteSelected)
    }
}

// MARK: - SummaryListInteractorOutput
extension SummaryListPresenter: SummaryListInteractorOutput {

    func foundSummaryList(_ products: [SummaryProduct]?, _ error: Error?) {
        guard error == nil else {
            self.summaryListViewInterface?.showError()
            return
        }
        guard let products = products else {
            self.summaryListViewInterface?.showError()
            return
        }
        self.updateSummaryListViewInterface(with: products)
    }
    
    func foundLatestSummaryList(_ products: [SummaryProduct]?) {
        guard let products = products else {
            self.summaryListViewInterface?.showError()
            return
        }
        self.updateLatestSummaryListViewInterface(with: products)
    }
}

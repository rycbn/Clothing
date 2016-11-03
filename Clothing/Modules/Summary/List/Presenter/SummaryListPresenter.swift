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
}

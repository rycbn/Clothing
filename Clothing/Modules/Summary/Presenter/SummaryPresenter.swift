//
//  SummaryPresenter.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryPresenter {

    var summaryInteractorInput: SummaryInteractorInput?
    var summaryViewInterface: SummaryViewInterface?
    var summaryRouter: SummaryRouter?


    func updateSummaryViewInterface(with products: [SummaryProduct]) {
        self.summaryViewInterface?.showDisplay(with: products)
    }
}

// MARK: - SummaryModuelInterface
extension SummaryPresenter: SummaryModuleInterface {
    
    func updateView() {
        self.summaryInteractorInput?.findSummary()
    }

    func requestAlert() {
        self.summaryRouter?.showAlert()
    }

}

// MARK: - SummaryInteractorOutput
extension SummaryPresenter: SummaryInteractorOutput {

    func foundSummary(_ products: [SummaryProduct]?, _ error: Error?) {
        guard error == nil else {
            self.summaryViewInterface?.showError()
            return
        }
        guard let products = products else {
            self.summaryViewInterface?.showError()
            return
        }
        self.updateSummaryViewInterface(with: products)
    }

}

//
//  SummaryListProtocol.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol SummaryListInteractorInput {
    func findSummaryList()
}

protocol SummaryListInteractorOutput {
    func foundSummaryList(_ products: [SummaryProduct]?, _ error: Error?)
}

protocol SummaryListModuleInterface {
    func updateView()
    func requestAlert()
    func nextView(with product: SummaryProduct)
}

protocol SummaryListViewInterface {
    func showError()
    func showDisplay(with data: [SummaryProduct])
    func reloadEntries()
}

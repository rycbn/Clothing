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
    func findLatestSummaryList(with productID: NSNumber, _ favouriteSelected: Bool)
}

protocol SummaryListInteractorOutput {
    func foundSummaryList(_ products: [SummaryProduct]?, _ error: Error?)
    func foundLatestSummaryList(_ products: [SummaryProduct]?)
}

protocol SummaryListModuleInterface {
    func updateView()
    func requestAlert()
    func nextView(with product: SummaryProduct)
    func updateView(with productID: NSNumber, _ favouriteSelected: Bool)
}

protocol SummaryListViewInterface {
    func showError()
    func showDisplay(with data: [SummaryProduct])
    func reloadEntries()
    func reloadCellAtItem(with data: [SummaryProduct])
}

//
//  SummaryProtocol.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol SummaryInteractorInput {
    func findSummary()
}

protocol SummaryInteractorOutput {
    func foundSummary(_ products: [SummaryProduct]?, _ error: Error?)
}

protocol SummaryModuleInterface {
    func updateView()
    func requestAlert()
    func requestSummaryDetail(with product: SummaryProduct)
}

protocol SummaryViewInterface {
    func showError()
    func showDisplay(with data: [SummaryProduct])
    func reloadEntries()
}

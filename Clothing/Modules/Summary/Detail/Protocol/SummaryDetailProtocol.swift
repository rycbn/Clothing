//
//  SummaryDetailProtocol.swift
//  Clothing
//
//  Created by Chau Boon Yong on 10/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol SummaryDetailInteractorInput {
    func fetchImage(withValue value: NSNumber)
}

protocol SummaryDetailInteractorOutput {
    func fetchedImage(with data: Data)
}

protocol SummaryDetailModuleInterface {
    func updateView(withValue value: NSNumber)
}

protocol SummaryDetailViewInterface {
    func showDisplay(with data: Data)
    func reloadEntries()
}

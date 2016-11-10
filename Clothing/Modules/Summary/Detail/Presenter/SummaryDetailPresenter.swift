//
//  SummaryDetailPresenter.swift
//  Clothing
//
//  Created by Chau Boon Yong on 10/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryDetailPresenter {
    
    var summaryDetailInteractorInput: SummaryDetailInteractorInput?
    var summaryDetailViewInterface: SummaryDetailViewInterface?
    
    func updateSummaryDetailViewInterface(with data: Data) {
        self.summaryDetailViewInterface?.showDisplay(with: data)
    }
}

// MARK:- SummaryDetailModuleInterface
extension SummaryDetailPresenter: SummaryDetailModuleInterface {
    
    func updateView(withValue value: NSNumber) {
        self.summaryDetailInteractorInput?.fetchImage(withValue: value)
    }
    
}

// MARK:- SummaryDetailViewInterface
extension SummaryDetailPresenter: SummaryDetailInteractorOutput {
    
    func fetchedImage(with data: Data) {
        self.updateSummaryDetailViewInterface(with: data)
    }
    
}

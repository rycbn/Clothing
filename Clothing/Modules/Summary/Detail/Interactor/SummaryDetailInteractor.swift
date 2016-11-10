//
//  SummaryDetailInteractor.swift
//  Clothing
//
//  Created by Chau Boon Yong on 10/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

class SummaryDetailInteractor {
 
    var summaryDetailInteractorOutput: SummaryDetailInteractorOutput?
    
    let summaryDetailDataManager: SummaryDetailDataManager
    
    init(_ summaryDetailDataManager: SummaryDetailDataManager) {
        self.summaryDetailDataManager = summaryDetailDataManager
    }
    
}

// MARK:- SummaryDetailInteractorInput
extension SummaryDetailInteractor: SummaryDetailInteractorInput {
    
    func fetchImage(withValue value: NSNumber) {
        self.summaryDetailDataManager.fetchingImaga(withValue: value) { [weak self] data in
            self?.summaryDetailInteractorOutput?.fetchedImage(with: data)
        }
    }
    
}

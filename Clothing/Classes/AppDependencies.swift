//
//  AppDependencies.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class AppDependencies: NSObject {

    let summaryListRouter = SummaryListRouter()

    override init() {
        super.init()
        self.configureDependencies()
    }

    func installRootViewController(into window: UIWindow) {
        self.summaryListRouter.presentSummaryListInterface(from: window)
    }

    func configureDependencies() {
        let networkManager = NetworkManager()
        let coreDataStore = CoreDataStore()
        let rootRouter = RootRouter()


        // Summary List Module
        let summaryListPresenter = SummaryListPresenter()
        let summaryListDataManager = SummaryListDataManager()
        let summaryListInteractor = SummaryListInteractor(summaryListDataManager)

        self.summaryListRouter.rootRouter = rootRouter
        self.summaryListRouter.summaryListPresenter = summaryListPresenter

        summaryListPresenter.summaryListRouter = self.summaryListRouter
        summaryListPresenter.summaryListInteractorInput = summaryListInteractor
        summaryListInteractor.summaryListInteractorOutput = summaryListPresenter
        summaryListDataManager.networkManager = networkManager
        summaryListDataManager.coreDataStore = coreDataStore
        
        // Summary Detail Module
        let summaryDetailRouter = SummaryDetailRouter()
        let summaryDetailPresenter = SummaryDetailPresenter()
        let summaryDetailDataManager = SummaryDetailDataManager()
        let summaryDetailInteractor = SummaryDetailInteractor(summaryDetailDataManager)
        
        self.summaryListRouter.summaryDetailRouter = summaryDetailRouter
        summaryDetailRouter.summaryDetailPresenter = summaryDetailPresenter
        summaryDetailPresenter.summaryDetailInteractorInput = summaryDetailInteractor
        summaryDetailInteractor.summaryDetailInteractorOutput = summaryDetailPresenter
    }
    
}

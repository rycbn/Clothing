//
//  AppDependencies.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class AppDependencies: NSObject {

    let summaryRouter = SummaryRouter()

    override init() {
        super.init()
        self.configureDependencies()
    }

    func installRootViewController(into window: UIWindow) {
        self.summaryRouter.presentSummaryInterface(from: window)
    }

    func configureDependencies() {
        let networkManager = NetworkManager()
        let coreDataStore = CoreDataStore()
        let rootRouter = RootRouter()


        // Summary Module
        let summaryPresenter = SummaryPresenter()
        let summaryDataManager = SummaryDataManager()
        let summaryInteractor = SummaryInteractor(summaryDataManager)

        self.summaryRouter.rootRouter = rootRouter
        self.summaryRouter.summaryPresenter = summaryPresenter

        summaryPresenter.summaryRouter = self.summaryRouter
        summaryPresenter.summaryInteractorInput = summaryInteractor
        summaryInteractor.summaryInteractorOutput = summaryPresenter
        summaryDataManager.networkManager = networkManager
        summaryDataManager.coreDataStore = coreDataStore
    }
}

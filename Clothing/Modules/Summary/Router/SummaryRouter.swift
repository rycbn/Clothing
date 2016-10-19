//
//  SummaryRouter.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class SummaryRouter {

    var summaryViewController: SummaryViewController?
    var summaryPresenter: SummaryPresenter?
    var rootRouter: RootRouter?

    func presentSummaryInterface(from window: UIWindow) {
        let viewController = self.summaryViewControllerFromStoryboard()
        viewController.eventHandler = self.summaryPresenter
        self.summaryViewController = viewController
        self.summaryPresenter?.summaryViewInterface = viewController
        self.rootRouter?.showRoot(viewController, inWindow: window)
    }

    func summaryViewControllerFromStoryboard() -> SummaryViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SummaryStoryboardID") as! SummaryViewController
        return viewController
    }
}

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
    var summaryDetailRouter: SummaryDetailRouter?

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

    func showAlert() {
        let title = "Sorry"
        let message = "Something wrong! Please try again!"
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        self.summaryViewController?.present(alertViewController, animated: true, completion: nil)
    }

    func showSummaryDetailInterface(with product: SummaryProduct) {
        let navigationController = self.summaryViewController?.navigationController
        self.summaryDetailRouter?.presentSummaryDetailInterface(from: navigationController, with: product)
    }
}

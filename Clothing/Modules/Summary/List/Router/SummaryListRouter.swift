//
//  SummaryListRouter.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class SummaryListRouter {
  
    var rootRouter: RootRouter?
    var summaryListViewController: SummaryListViewController?
    var summaryListPresenter: SummaryListPresenter?
    var summaryDetailRouter: SummaryDetailRouter?

    func presentSummaryListInterface(from window: UIWindow) {
        let viewController = self.summaryListViewControllerFromStoryboard()
        viewController.eventHandler = self.summaryListPresenter
        self.summaryListViewController = viewController
        self.summaryListPresenter?.summaryListViewInterface = viewController
        self.rootRouter?.showRoot(viewController, inWindow: window)
    }

    func summaryListViewControllerFromStoryboard() -> SummaryListViewController {
        let storyboard = UIStoryboard.mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: .summaryListStoryboardID) as! SummaryListViewController
        return viewController
    }

    func showAlert() {
        let alertViewController = UIAlertController(title: .sorry, message: .somethingWrong, preferredStyle: .alert)
        let okAction = UIAlertAction(title: .ok, style: .default, handler: nil)
        alertViewController.addAction(okAction)
        self.summaryListViewController?.present(alertViewController, animated: true, completion: nil)
    }
    
    func showSummaryDetailInterface(with product: SummaryProduct) {
        let navigationController = self.summaryListViewController?.navigationController
        self.summaryDetailRouter?.presentSummaryDetailInterface(from: navigationController, with: product)
    }
    
    func showSummaryDetailInterface3DTouch(with viewController: SummaryDetailViewController) {
        let navigationController = self.summaryListViewController?.navigationController
        self.summaryDetailRouter?.presentSummaryDetailInterface3DTouch(from: navigationController, inViewController: viewController)
    }
}

//
//  SummaryDetailRouter.swift
//  Clothing
//
//  Created by Chau Boon Yong on 03/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class SummaryDetailRouter {
    
    var summaryDetailViewController: SummaryDetailViewController?
    var summaryDetailPresenter: SummaryDetailPresenter?
    
    func presentSummaryDetailInterface(from navigationController: UINavigationController?, with product: SummaryProduct) {
        let viewController = self.summaryDetailViewControllerFromStoryboard()
        viewController.product = product
        viewController.isPreviewing = false
        viewController.eventHandler = self.summaryDetailPresenter
        self.summaryDetailViewController = viewController
        self.summaryDetailPresenter?.summaryDetailViewInterface = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func summaryDetailViewControllerFromStoryboard() -> SummaryDetailViewController {
        let storyboard = UIStoryboard.mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: .summaryDetailStoryboardID) as! SummaryDetailViewController
        return viewController
    }
    
    func presentSummaryDetailInterface3DTouch(from navigationController: UINavigationController?, inViewController viewController: SummaryDetailViewController) {
        viewController.eventHandler = self.summaryDetailPresenter
        self.summaryDetailPresenter?.summaryDetailViewInterface = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

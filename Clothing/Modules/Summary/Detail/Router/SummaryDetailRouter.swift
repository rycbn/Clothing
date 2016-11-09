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
    
    func presentSummaryDetailInterface(from navigationController: UINavigationController?, with product: SummaryProduct) {
        let viewController = self.summaryDetailViewControllerFromStoryboard()
        viewController.product = product
        self.summaryDetailViewController = viewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func summaryDetailViewControllerFromStoryboard() -> SummaryDetailViewController {
        let storyboard = UIStoryboard.mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: .summaryDetailStoryboardID) as! SummaryDetailViewController
        return viewController
    }
    
}

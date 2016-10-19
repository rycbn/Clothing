//
//  RootRouter.swift
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class RootRouter {

    func showRoot(_ viewController: UIViewController, inWindow window: UIWindow) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
    
}

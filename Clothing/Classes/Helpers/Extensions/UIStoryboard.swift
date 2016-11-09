//
//  UIStoryboard.swift
//  Clothing
//
//  Created by Chau Boon Yong on 09/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

enum StoryboardIdentifier: String {
    case main
}

enum ViewControllerIdentifier: String {
    case summaryListStoryboardID
    case summaryDetailStoryboardID
}

internal extension UIStoryboard {
    
    convenience init(name: StoryboardIdentifier, bundle: Bundle?) {
        self.init(name: name.rawValue.capitalized, bundle: bundle)
    }
    
    func instantiateViewController(withIdentifier identifier: ViewControllerIdentifier) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    class func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: .main, bundle: Bundle.main)
        return storyboard
    }
    
}

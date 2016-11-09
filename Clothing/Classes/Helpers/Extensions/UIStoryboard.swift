//
//  UIStoryboard.swift
//  Clothing
//
//  Created by Chau Boon Yong on 09/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

internal extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: ConstantKeys.Identifier.main.rawValue.capitalized, bundle: Bundle.main)
        return storyboard
    }
    
}

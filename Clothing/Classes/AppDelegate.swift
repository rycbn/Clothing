//
//  AppDelegate.swift
//  Clothing
//
//  Created by Chau Boon Yong on 29/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func configureAppDependencies() {
        let appDependencies = AppDependencies()
        appDependencies.installRootViewController(into: self.window)
    }

}

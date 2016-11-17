//
//  ShortcutItem.swift
//  Clothing
//
//  Created by Chau Boon Yong on 17/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

enum ShortcutItem: String {
    case home = "com.rycbn.home"

    enum LocalizedTitle: String {
        case home = "Home"
    }
    enum LocalizedSubtitle: String {
        case summaryList = "Summary List"
    }
}

extension UIApplicationShortcutItem {

    convenience init(type: ShortcutItem, localizedTitle title: ShortcutItem.LocalizedTitle, localizedSubtitle subtitle: ShortcutItem.LocalizedSubtitle?, icon: UIApplicationShortcutIcon?, userInfo: [AnyHashable : Any]? = nil) {
        self.init(type: type.rawValue, localizedTitle: title.rawValue, localizedSubtitle: subtitle?.rawValue, icon: icon, userInfo: userInfo)
    }
    
}

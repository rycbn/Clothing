//
//  ShortcutItem.swift
//  Clothing
//
//  Created by Chau Boon Yong on 17/11/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

enum ShortcutItemType: String {
    case homeType = "com.rycbn.home"
}

extension UIApplicationShortcutItem {

    convenience init(type: ShortcutItemType, localizedTitle title: String, localizedSubtitle subtitle: String?, icon: UIApplicationShortcutIcon?, userInfo: [AnyHashable : Any]? = nil) {
        self.init(type: type.rawValue, localizedTitle: title, localizedSubtitle: subtitle, icon: icon, userInfo: userInfo)
    }
    
}

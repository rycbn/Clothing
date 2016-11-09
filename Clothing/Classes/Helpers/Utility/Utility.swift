//
//  Utility.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class Utility {

    class func getFormattedAmount(_ amount: NSNumber, _ divisor: NSNumber, _ code: String) -> String {
        let formatedAmount = Int(amount) / Int(divisor) as NSNumber
        let currencyStyle = self.getCurrencyValueStyle(formatedAmount)
        let currencySymbol = self.getCurrencySymbol(for: code)
        let formattedString = "\(currencySymbol)\(currencyStyle)"
        return formattedString
    }

    class func getCurrencyValueStyle(_ amount: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedString = formatter.string(from: amount) ?? ""
        return formattedString
    }

    class  func getCurrencySymbol(for code: String) -> String {
        let locale = Locale(identifier: code) as NSLocale
        let formattedString = locale.displayName(forKey: .currencySymbol, value: code) ?? ""
        return formattedString
    }

    class func subtituteKey(in method: String, key: String, value: String) -> String {
        let formattedMethod = method.replacingOccurrences(of: "{\(key)}", with: value)
        return formattedMethod
    }
    
}



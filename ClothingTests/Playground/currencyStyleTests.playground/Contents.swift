//: Playground - noun: a place where people can play

import UIKit

// Test currency style
let amount: NSNumber = 1234 // 123.45 // 1234567.89
let currencyCode = "GBP"
func getCurrencyValueStyle(_ amount: NSNumber) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    let formattedString = formatter.string(from: amount) ?? ""
    return formattedString
}

func getCurrencySymbol(for code: String) -> String {
    let locale = Locale(identifier: code) as NSLocale
    let formattedString = locale.displayName(forKey: .currencySymbol, value: code) ?? ""
    return formattedString
}

let formattedAmount = getCurrencyValueStyle(amount)
let formattedCurrencyStyle = getCurrencySymbol(for: currencyCode)

func processingCurrencyAmount(_ amount: String, currencyCode: String) -> String {
    return "\(currencyCode)\(amount)"
}

let formattedCurrencyAmount = processingCurrencyAmount(formattedAmount, currencyCode: formattedCurrencyStyle)
print(formattedCurrencyAmount)

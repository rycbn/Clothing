//
//  UtilityTests.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import Clothing

class UtilityTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_ShouldSetGBPSymbol() {
        let currencyCode = "GBP"
        let symbol = Utility.getCurrencySymbol(for: currencyCode)
        XCTAssertEqual("£", symbol)
    }

    func test_ShouldSetUSDSymbol() {
        let currencyCode = "USD"
        let symbol = Utility.getCurrencySymbol(for: currencyCode)
        XCTAssertEqual("$", symbol)
    }

    func test_ShouldSetEuroSymbol() {
        let currencyCode = "EUR"
        let symbol = Utility.getCurrencySymbol(for: currencyCode)
        XCTAssertEqual("€", symbol)
    }

    func test_ShouldSetNoDecimalInThreeDigitNumber() {
        let amount: NSNumber = 123
        let formatedAmount = Utility.getCurrencyValueStyle(amount)
        XCTAssertEqual("123", formatedAmount)
    }

    func test_ShouldSetCommonInFourDigitNumber() {
        let amount: NSNumber = 1234
        let formattedAmount = Utility.getCurrencyValueStyle(amount)
        XCTAssertEqual("1,234", formattedAmount)
    }

    func test_ShouldSetCurrencySymbolAndCurrencyValueStayle() {
        let amount: NSNumber = 343100
        let dividor: NSNumber = 100
        let currencyCode = "GBP"
        let formattedAmount = Utility.getFormattedAmount(amount, dividor, currencyCode)
        XCTAssertEqual("£3,431", formattedAmount)
    }
}

//
//  SummaryViewControllerTests.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import Clothing

class SummaryViewControllerTests: XCTestCase {

    let router = SummaryRouter()

    var sut: SummaryViewController!
    var mainView: SummaryView!

    override func setUp() {
        super.setUp()
        sut = router.summaryViewControllerFromStoryboard()
        mainView = sut.view as! SummaryView
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_ShouldSetSummaryViewController() {
        XCTAssertNotNil(sut)
    }

    func test_ShouldSetSummaryView() {
        XCTAssertNotNil(mainView)
    }

}

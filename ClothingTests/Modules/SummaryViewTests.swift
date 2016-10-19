//
//  SummaryViewTests.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import Clothing

class SummaryViewTests: XCTestCase {

    let router = SummaryRouter()

    var controller: SummaryViewController!
    var sut: SummaryView!

    override func setUp() {
        super.setUp()
        controller = router.summaryViewControllerFromStoryboard()
        sut = controller.view as! SummaryView
    }

    func test_ShouldSetCollectionView() {
        XCTAssertNotNil(sut.collectionView)
    }
}

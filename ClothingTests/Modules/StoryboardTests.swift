//
//  StoryboardTests.swift
//  Clothing
//
//  Created by Roger Yong on 19/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import Clothing

class StoryboardTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_ShouldSetMainStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        XCTAssertNotNil(storyboard)
    }
}

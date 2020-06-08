//
//  ResultsViewControllerTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 08.06.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import XCTest
@testable import QuizApp

class ResultsViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoadRenderSummary() {
        let sut = ResultsViewController(summary: "summary")
        _ = sut.view
        
        XCTAssertEqual(sut.headerLabel.text, "summary")
    }

}

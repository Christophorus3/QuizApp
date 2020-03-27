//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 25.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoadRendersQuestionHeaderText() {
        let sut = makeSUT(question: "Q1", options: [])
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }

    func testViewDidLoadZeroOptionsRendersNoOptions() {
        let sut = makeSUT(question: "Q1", options: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewDidLoadOneOptionRendersOneOption() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
                
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testViewDidLoadOneOptionRendersOneOptionText() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
    
    func makeSUT(question: String, options: [String]) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options)
        _ = sut.view //loading the view
        return sut
    }
}

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
        let sut = makeSUT(summary: "summary")
        
        XCTAssertEqual(sut.headerLabel.text, "summary")
    }
    
    func testViewDidLoadWithoutAnswersDoesNotRenderAnswerd() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewDidLoadWithOneAnswerRendersAnswer() {
        let sut = makeSUT(summary: "summary", answers: [makeMockAnswer()])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testViewDidLoadWithCorrectAnserRendersCorrectAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func testViewDidLoadWithWrongAnserRendersWrongAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
    }

    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeMockAnswer() -> PresentableAnswer {
        return PresentableAnswer(isCorrect: false)
    }
}

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
    
    func testViewDidLoadWithoutAnswersDoesNotRenderAnswer() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewDidLoadWithOneAnswerRendersAnswer() {
        let sut = makeSUT(summary: "summary", answers: [makeAnswer()])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testViewDidLoadWithCorrectAnswerRendersQuestionAnswerText() {
        let answer = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func testViewDidLoadWithWrongAnswerRendersQuestionAnswerText() {
        let answer = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }

    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question,
                                 answer: answer,
                                 wrongAnswer: wrongAnswer)
    }
}

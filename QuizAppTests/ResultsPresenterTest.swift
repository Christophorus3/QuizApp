//
//  ResultsPresenterTest.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 05.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class ResultsPresenterTest: XCTestCase {
    
    func testSummaryWithThreeQuestionsAndScoreTwoReturnsSummary() {
        let answers = [Question.singleAnswer("Q1"):["A1"], Question.multipleAnswer("Q2"):["A2", "A3"], Question.singleAnswer("Q3"):["A4"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 2/3 correct")
    }
    
    func testPresentableAnswersEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func testSingleWrongPresentableAnswerPresents() {
        let answers = [Question.singleAnswer("Q1"):["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"):["A2"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func testMultipleWrongPresentableAnswerPresents() {
        let answers = [Question.singleAnswer("Q1"):["A1", "A4"]]
        let correctAnswers = [Question.singleAnswer("Q1"):["A2", "A3"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func testSignleRightPresentableAnswerPresents() {
        let answers = [Question.singleAnswer("Q1"):["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"):["A1"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func testMultipleRightPresentableAnswerPresents() {
        let answers = [Question.singleAnswer("Q1"):["A1", "A4"]]
        let correctAnswers = [Question.singleAnswer("Q1"):["A1", "A4"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
}

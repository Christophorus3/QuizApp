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
    
    let q1 = Question.singleAnswer("Q1")
    let q2 = Question.multipleAnswer("Q2")
    let q3 = Question.singleAnswer("Q3")
    let q4 = Question.multipleAnswer("Q4")
    
    func test_title_returnsFormattedTitle() {
        let answers = [q1: ["A1"], q2: ["A2", "A3"], q3: ["A4"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [q1, q2], correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func testSummaryWithThreeQuestionsAndScoreTwoReturnsSummary() {
        let answers = [q1: ["A1"], q2: ["A2", "A3"], q3: ["A4"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [q1, q2], correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 2/3 correct")
    }
    
    func testPresentableAnswersEmpty() {
        let answers = [Question<String>: [String]]()
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [], correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func testSingleWrongPresentableAnswerPresents() {
        let answers = [q1: ["A1"]]
        let correctAnswers = [q1: ["A2"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [q1], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func testMultipleWrongPresentableAnswerPresents() {
        let answers = [q2: ["A1", "A4"]]
        let correctAnswers = [q2:["A2", "A3"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [q2], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func testSignleRightPresentableAnswerPresents() {
        let answers = [q1: ["A1"]]
        let correctAnswers = [q1:["A1"]]
        let result = Result(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, questions: [q1], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func testMultipleRightPresentableAnswersPresents() {
        let answers = [q2:["A1", "A4"]]
        let correctAnswers = [q2:["A1", "A4"]]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: [q2], correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
    }
    
    func testMultipleRightPresentableAnswersPresentsTwoQuestionsInRightOrder() {
        let answers = [q1: ["A3"], q2: ["A1", "A4"]]
        let correctAnswers = [q2:["A1", "A4"], q1: ["A3"]]
        let orderedQuestions = [q1, q2]
        let result = Result(answers: answers, score: 2)
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A3")
        XCTAssertNil(sut.presentableAnswers.first!.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.last!.wrongAnswer)
    }
}

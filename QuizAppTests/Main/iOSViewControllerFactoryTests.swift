//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 05.12.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import XCTest
import UIKit
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    let options = ["A1", "A2"]
    let q1 = Question.singleAnswer("Q1")
    let q2 = Question.multipleAnswer("Q2")
    let questions = [Question.singleAnswer("Q1"),
                     Question.multipleAnswer("Q2")]
    
    
    func testCreatesViewControllerForSingleAnswerQuestionWithTitle() {
        let presenter = QuestionPresenter(questions: questions, currentQuestion: q2)
        
        XCTAssertEqual(makeQuestionController(question: q2).title, presenter.title)
    }
    
    func testCreatesViewControllerForSingleAnswerQuestion() {
        XCTAssertEqual(makeQuestionController(question: q1).question, "Q1")
    }
    
    func testCreatesViewControllerForSingleAnswerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func testCreatesViewControllerForSingleAnswerSingleSelection() {
        let controller = makeQuestionController()
        XCTAssertFalse(controller.allowsMultipleSelection)
    }
    
    func testCreatesViewControllerForMultipleAnswerQuestion() {
        XCTAssertEqual(makeQuestionController(question: q2).question, "Q2")
    }
    
    func testCreatesViewControllerForMultipleAnswerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: q2).options, options)
    }
    
    func testCreatesViewControllerForMultipleAnswerSingleSelection() {
        let controller = makeQuestionController(question: q2)
        XCTAssertTrue(controller.allowsMultipleSelection)
    }
    
    func test_resultsViewController_createsControllerWithTitle() {
        let (controller, presenter) = makeResults()
        
        XCTAssertEqual(controller.title, presenter.title)
    }
    
    func test_resultsViewController_createsControllerWithSummary() {
        let (controller, presenter) = makeResults()
        
        XCTAssertEqual(controller.summary, presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswers() {
        let (controller, presenter) = makeResults()
        
        XCTAssertEqual(controller.answers.count, presenter.presentableAnswers.count)
    }
    
    // MARK: - helpers
    
    func makeSUT(options: [Question<String>:[String]] = [:],
                 correctAnswers: [Question<String>:[String]] = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
    
    func makeResults() -> (ResultsViewController, ResultsPresenter) {
        let userAnswers = [q1: ["A1"], q2: ["A2", "A3"]]
        let correctAnswers = [q1: ["A1"], q2: ["A2", "A3"]]
        let result = Result.make(answers: userAnswers, score: 2)
        
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        
        return (controller, presenter)
    }
}

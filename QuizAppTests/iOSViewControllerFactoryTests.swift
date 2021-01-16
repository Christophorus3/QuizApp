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
                     Question.singleAnswer("Q2")]
    
    
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
        
        _ = controller.view
        
        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }
    
    func testCreatesViewControllerForMultipleAnswerQuestion() {
        XCTAssertEqual(makeQuestionController(question: q2).question, "Q2")
    }
    
    func testCreatesViewControllerForMultipleAnswerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: q2).options, options)
    }
    
    func testCreatesViewControllerForMultipleAnswerSingleSelection() {
        let controller = makeQuestionController(question: q2)
        
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: - helpers
    
    func makeSUT(options: [Question<String>:[String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: questions, options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}

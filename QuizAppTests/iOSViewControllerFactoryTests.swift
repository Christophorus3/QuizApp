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
    
    func testCreatesViewControllerForSingleAnswerQuestion() {
        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question, "Q1")
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
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }
    
    func testCreatesViewControllerForMultipleAnswerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).options, options)
    }
    
    func testCreatesViewControllerForMultipleAnswerSingleSelection() {
        let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))
        
        _ = controller.view
        
        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }
    
    // MARK: - helpers
    
    func makeSUT(options: [Question<String>:[String]]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}

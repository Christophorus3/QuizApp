//
//  iOSViewControllerFactoryTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 05.12.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTests: XCTestCase {
    
    func testCreatesViewControllerForQuestion() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as! QuestionViewController
        
        XCTAssertEqual(controller.question, "Q1")
    }
    
    func testCreatesViewControllerWithOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
        
        XCTAssertEqual(controller.options, options)
    }
}

//
//  QuestionTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 24.11.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionTests: XCTestCase {

    func testHashValueSingleAnswer() {
        let type = "a string"
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func testHashValueMultipleAnswer() {
        let type = "a string"
        let sut = Question.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func testEqualSingleAnswerIsEqual() {
        let type = "a string"
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(Question.singleAnswer(type), Question.singleAnswer(type))
    }
    
    func testNotEqualSingleAnswerIsNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("answer"), Question.singleAnswer("another"))
    }
    
    func testEqualMultipleAnswerIsEqual() {
        let type = "a string"

        XCTAssertEqual(Question.multipleAnswer(type), Question.multipleAnswer(type))
    }
    
    func testNotEqualMultipleAnswerIsNotEqual() {
        XCTAssertNotEqual(Question.multipleAnswer("answer"), Question.multipleAnswer("another"))
    }
}

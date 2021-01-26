//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 16.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    
    let q1 = Question.singleAnswer("Q1")
    let q2 = Question.singleAnswer("Q2")
    let q3 = Question.singleAnswer("Q3")
    
    func testTitleForFirstQuestion() {
        let sut = QuestionPresenter(questions: [q1], currentQuestion: q1)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func testTitleForSecondQuestion() {
        let sut = QuestionPresenter(questions: [q1, q2], currentQuestion: q2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func testTitleForQuestionNotInQuestions() {
        let sut = QuestionPresenter(questions: [q1, q2], currentQuestion: q3)
        
        XCTAssertNil(sut.title)
    }
    
    func testTitleForNoQuestions() {
        let sut = QuestionPresenter(questions: [], currentQuestion: q3)
        
        XCTAssertNil(sut.title)
    }
    
}

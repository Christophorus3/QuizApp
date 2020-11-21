//
//  NavigationControllerRouterTest.swift
//  QuizEngineTests
//
//  Created by Christoph Wottawa on 31.10.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    func testRouteToQuestionPresentsQuestion() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: {_ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func testRouteToQuestionTwicePresentsQuestion() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: {_ in })
        sut.routeTo(question: "Q2", answerCallback: {_ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}

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
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut = NavigationControllerRouter(navigationController, factory: factory)

    func testRouteToQuestionTwiceShowsQuestionWithVCFactory() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        let question1 = Question.singleAnswer("Q1")
        let question2 = Question.singleAnswer("Q2")
        factory.stub(question:question1, with:viewController)
        factory.stub(question:question2, with:secondViewController)
        
        sut.routeTo(question: question1, answerCallback: {_ in })
        sut.routeTo(question: question2, answerCallback: {_ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func testRouteToSingleAnswerQuestionProgressesToNextQuestion() {
        var callbackFired = false
        let question = Question.singleAnswer("Q1")
        sut.routeTo(question: question, answerCallback: { _ in callbackFired = true })
        factory.stubbedCallbacks[question]!([""])

        XCTAssertTrue(callbackFired)
    }
    
    func testRouteToSingleAnswerQuestionConfiguresVCWithoutSubmitButton() {
        let viewController = UIViewController()
        let question = Question.singleAnswer("Q1")
        factory.stub(question:question, with:viewController)
        sut.routeTo(question:question, answerCallback: { _ in })

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func testRouteToMultipleAnswerQuestionDoesNotProgressToNextQuestion() {
        var callbackFired = false
        let question = Question.multipleAnswer("Q1")
        sut.routeTo(question: question, answerCallback: { _ in callbackFired = true })
        factory.stubbedCallbacks[question]!([""])

        XCTAssertFalse(callbackFired)
    }
    
    func testRouteToMultipleAnswerQuestionConfiguresVCWithSubmitButton() {
        let viewController = UIViewController()
        let question = Question.multipleAnswer("Q1")
        factory.stub(question:question, with:viewController)
        sut.routeTo(question:question, answerCallback: { _ in })

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func testRouteToMultipleAnswerQuestionConfiguresVCWithSubmitButtonDisabled() {
        let viewController = UIViewController()
        let question = Question.multipleAnswer("Q1")
        factory.stub(question:question, with:viewController)
        sut.routeTo(question:question, answerCallback: { _ in })
    
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.stubbedCallbacks[question]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.stubbedCallbacks[question]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func testRouteToMultipleAnswerQuestionProgressesToNextQuestion() {
        var callbackFired = false
        let viewController = UIViewController()
        let question = Question.multipleAnswer("Q1")
        factory.stub(question:question, with:viewController)
        sut.routeTo(question:question, answerCallback: { _ in callbackFired = true })
        
        factory.stubbedCallbacks[question]!(["A1"])
        let button = viewController.navigationItem.rightBarButtonItem!
        
        button.simulateTap()
        
        XCTAssertTrue(callbackFired)
    }
    
    func testRouteToResultShowsResultVC() {
        let viewController = UIViewController()
        let result = Result(answers: [Question.singleAnswer("Q1"): ["A1"]], score: 10)
        
        let secondViewController = UIViewController()
        let result2 = Result(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 20)
        
        factory.stub(result:result, with:viewController)
        factory.stub(result:result2, with:secondViewController)

        sut.routeTo(results:result)
        sut.routeTo(results:result2)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)

    }
}

// MARK: - Helpers

class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedVCs = [Question<String>: UIViewController]()
    private var stubbedResults = [Result<Question<String>, [String]>: UIViewController]()
    var stubbedCallbacks = [Question<String>: ([String]) -> Void]()

    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedVCs[question] = viewController
    }
    
    func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
        stubbedResults[result] = viewController
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        self.stubbedCallbacks[question] = answerCallback
        return stubbedVCs[question] ?? UIViewController()
    }
    
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return stubbedResults[result] ?? UIViewController()
    }
}

private extension UIBarButtonItem {
    
    func simulateTap() {
        self.target!.performSelector(onMainThread: self.action!, with: nil, waitUntilDone: true)
    }
}

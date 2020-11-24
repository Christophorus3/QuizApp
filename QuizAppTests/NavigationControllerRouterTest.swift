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

    func testRouteToQuestionTwicePresentsQuestionWithVCFactory() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()

        factory.stub(question:"Q1", with:viewController)
        factory.stub(question:"Q2", with:secondViewController)
        
        sut.routeTo(question: "Q1", answerCallback: {_ in })
        sut.routeTo(question: "Q2", answerCallback: {_ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func testRouteToQuestionTwicePresentsQuestionWithRightCallback() {
        var callbackFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackFired = true })
        factory.stubbedCallbacks["Q1"]!("")

        XCTAssertTrue(callbackFired)
    }
}

class NonAnimatedNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

class ViewControllerFactoryStub: ViewControllerFactory {

    private var stubbedVCs = [String: UIViewController]()
    var stubbedCallbacks = [String: (String) -> Void]()

    
    func stub(question: String, with viewController: UIViewController) {
        stubbedVCs[question] = viewController
    }
    
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
        self.stubbedCallbacks[question] = answerCallback
        return stubbedVCs[question] ?? UIViewController()
    }
}

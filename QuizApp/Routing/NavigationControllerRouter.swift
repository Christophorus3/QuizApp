//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 21.11.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController,
         factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: answerCallback))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: nil)
            let buttonController = SubmitButtonController(button, answerCallback)
            let vc = factory.questionViewController(for: question, answerCallback: { selection in
                buttonController.update(selection)
            })
            
            vc.navigationItem.rightBarButtonItem = button
            show(vc)
        }
    }
    
    func routeTo(results: Result<Question<String>, [String]>) {
        show(factory.resultsViewController(for: results))
    }
    
    // MARK: - private
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    
    private var model: [String] = []
    
    init(_ button: UIBarButtonItem, _ callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }
    
    @objc private func fireCallback() {
        callback(model)
    }
}

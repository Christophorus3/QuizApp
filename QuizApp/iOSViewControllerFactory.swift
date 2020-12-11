//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 05.12.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private var options = [Question<String>: [String]]()
    
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldnt find options for question \(question)")
        }
        return questionVC(for: question, options: options, answerCallback: answerCallback)
    }
    
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
    
    private func questionVC(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, selection: answerCallback)
        case .multipleAnswer(let value):
            let vc = QuestionViewController(question: value, options: options, selection: answerCallback)
            let _ = vc.view
            vc.tableView.allowsMultipleSelection = true
            return vc
        }
    }
}

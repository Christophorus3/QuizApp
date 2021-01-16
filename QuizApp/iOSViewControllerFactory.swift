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
    
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    
    init(questions: [Question<String>],
         options: [Question<String>: [String]]) {
        self.questions = questions
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
            let vc = questionVC(for: question, value: value, options: options, answerCallback: answerCallback)
            return vc
        case .multipleAnswer(let value):
            let vc = questionVC(for: question, value: value, options: options, answerCallback: answerCallback)
            let _ = vc.view
            vc.tableView.allowsMultipleSelection = true
            return vc
        }
    }
    
    private func questionVC(for question: Question<String>, value: String, options: [String], answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, currentQuestion: question)
        let vc = QuestionViewController(question: value, options: options, selection: answerCallback)
        vc.title = presenter.title
        return vc
    }
}

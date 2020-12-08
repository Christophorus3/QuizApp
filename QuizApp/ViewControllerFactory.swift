//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 05.12.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    
    func resultsViewController(for result: Result<Question<String>, String>) -> UIViewController
}

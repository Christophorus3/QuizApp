//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 16.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let currentQuestion: Question<String>
    
    var title: String? {
        guard let questionIndex = questions.firstIndex(of: currentQuestion) else { return nil }
        return "Question #\(questionIndex + 1)"
    }
}

//
//  ResultsPresenter.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 05.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let result: Result<Question<String>, [String]>
    let correctAnswers: [Question<String>: [String]]
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return result.answers.map { (question, answers) in
            guard let correctAnswer = correctAnswers[question] else {
                fatalError("Could not find correct answer for question: \(question)")
            }
            
            return presentableAnswer(question, answers, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
}

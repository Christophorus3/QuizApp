//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 05.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import Foundation
@testable import QuizEngine

extension Result {
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }
}

extension Result: Equatable where Answer: Equatable {
    public static func ==(lhs:Result<Question, Answer>, rhs:Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension Result: Hashable where Answer: Equatable {
    public var hashValue: Int {
        return 1
    }
}

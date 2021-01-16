//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 05.01.21.
//  Copyright © 2021 Christoph Wottawa. All rights reserved.
//

import Foundation
import QuizEngine

extension Result: Hashable {
    public var hashValue: Int {
        return 1
    }
    
    public static func ==(lhs:Result<Question, Answer>, rhs:Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}

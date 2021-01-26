//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 25.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let q1 = Question.singleAnswer("What's Mike's nationality?")
        let o1 = "Canadian"
        let o2 = "American"
        let o3 = "Greek"
        
        let q2 = Question.multipleAnswer("What are Caio's nationalities?")
        let o4 = "Portuguese"
        let o5 = "American"
        let o6 = "Brazilian"
        
        let questions = [q1, q2]
        let options = [q1: [o1, o2, o3],
                       q2: [o4, o5, o6]]
        
        let correctAnswers = [q1: [o3], q2: [o4, o6]]
        
        let factory = iOSViewControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
        
        let navigationController = UINavigationController()
        
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
        
        return true
    }
}


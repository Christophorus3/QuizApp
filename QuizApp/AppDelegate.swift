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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let questionViewController = QuestionViewController(question: "A question",
                                                            options: ["Option 1", "Option 2"],
                                                            allowsMultipleSelection: false) {
                                                                print($0)
        }
        
        let resultsViewController = ResultsViewController(summary: "Yout got 1/2", answers: [
            PresentableAnswer(question: "Question?? Question?? Question?? Question?? Question?? Question?? Question?? Question??", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah!", wrongAnswer: nil),
            PresentableAnswer(question: "Another Question??", answer: "Hell yeah", wrongAnswer: "Hell no!")])
        // load view
        _ = questionViewController.view
        _ = resultsViewController.view
        
        questionViewController.tableView.allowsMultipleSelection = false
        //window.rootViewController = questionViewController
        window.rootViewController = resultsViewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}


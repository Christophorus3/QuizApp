//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 08.06.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit

struct PresentableAnswer {
    let question: String
    let ansswer: String
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
}

class WrongAnswerCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
}

class ResultsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = summary
        tableView.register(UINib(nibName: "CorrectAnswerCell", bundle: nil), forCellReuseIdentifier: "CorrectAnswerCell")
        tableView.register(UINib(nibName: "WrongAnswerCell", bundle: nil), forCellReuseIdentifier: "WrongAnswerCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.isCorrect {
            return correctAnswerCell(for: answer)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
            cell.questionLabel.text = answer.question
            cell.correctAnswerLabel.text = answer.ansswer
            return cell
        }
    }
    
    private func correctAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.ansswer
        return cell
    }
    
    
}

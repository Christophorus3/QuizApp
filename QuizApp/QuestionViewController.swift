//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 25.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit

typealias SelectionCallback = ([String]) -> ()

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var question = ""
    private var options = [String]()
    private var selection: SelectionCallback?
    
    
    private let reuseIdentifier = "Cell"

    convenience init(question: String,
                     options: [String],
                     selection: SelectionCallback?) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let options = tableView.indexPathsForSelectedRows!.map {
            self.options[$0.row]
        }
        self.selection?(options)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let options = tableView.indexPathsForSelectedRows!.map {
            self.options[$0.row]
        }
        self.selection?(options)
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }


}

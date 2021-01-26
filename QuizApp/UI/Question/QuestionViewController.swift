//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 25.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit
import QuizEngine

typealias SelectionCallback = ([String]) -> ()

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var question = ""
    private(set) var options = [String]()
    private(set) var allowsMultipleSelection = false
    private var selection: SelectionCallback?
    
    private let reuseIdentifier = "Cell"

    convenience init(question: String,
                     options: [String],
                     allowsMultipleSelection: Bool,
                     selection: SelectionCallback?) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.selection = selection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
        tableView.allowsMultipleSelection = allowsMultipleSelection
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
        let options = selectedOptions(in: tableView)
        self.selection?(options)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            self.selection?(selectedOptions(in: tableView)) 
        }
    }
    
    private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return selectedIndexPaths.map {
            self.options[$0.row]
        }
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }


}

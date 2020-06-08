//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 08.06.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    
    private var summary = ""
    
    convenience init(summary: String) {
        self.init()
        self.summary = summary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = summary
    }
    
}

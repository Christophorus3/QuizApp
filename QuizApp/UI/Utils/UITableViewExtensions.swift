//
//  UITableViewExtensions.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 16.06.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
}


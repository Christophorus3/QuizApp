//
//  TableViewTestHelpers.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 08.06.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import UIKit

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
    
    func select(row: Int) {
        selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    func deselect(row: Int) {
        deselectRow(at: IndexPath(row: row, section: 0), animated: false)
        delegate?.tableView?(self, didDeselectRowAt: IndexPath(row: row, section: 0))
    }
}

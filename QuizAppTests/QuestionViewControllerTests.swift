//
//  QuestionViewControllerTests.swift
//  QuizAppTests
//
//  Created by Christoph Wottawa on 25.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoadRendersQuestionHeaderText() {
        let sut = makeSUT(question: "Q1")
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }

    func testViewDidLoadZeroOptionsRendersNoOptions() {
        let sut = makeSUT(options: [])
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testViewDidLoadOneOptionRendersOneOption() {
        let sut = makeSUT(options: ["A1"])
                
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testViewDidLoadOneOptionRendersOneOptionText() {
        let sut = makeSUT(question: "Q1", options: ["A1"])
        let title = sut.tableView.title(at: 0)
        
        XCTAssertEqual(title, "A1")
    }
    
    func testOptionSelectedWithTwoOptionsNotifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func testOptionSelectedWithTwoOptionsMultipleSelectionEnabledNotifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func testOptionDeselectedWithTwoOptionsMultipleSelectionEnabledNotifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) {
            receivedAnswer = $0
        }
        sut.tableView.allowsMultipleSelection = true
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    // MARK: - Helper
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: SelectionCallback? = nil) -> QuestionViewController {
        let sut = QuestionViewController(question: question,
                                         options: options,
                                         selection: selection)
        _ = sut.view //loading the view
        return sut
    }
}

private extension UITableView {
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
        delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    
}

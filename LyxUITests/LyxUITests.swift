//
//  LyxUITests.swift
//  LyxUITests
//
//  Created by Miroslav Ivanov on 01/12/2016.
//  Copyright © 2016 Miroslav Ivanov. All rights reserved.
//

import XCTest

class LyxUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddFavorite() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Events in Town"].buttons["Favorites"].tap()
        XCTAssertEqual(cells.count, 0, "found insted: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Hardwell")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count, 1, "found insted: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Tiesto")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count, 2, "found insted: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Events"].tap()
        app.navigationBars["Events in Town"].buttons["Favorites"].tap()
        sleep(1)
    }

    func testSwipeToDelete() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Events in Town"].buttons["Favorites"].tap()
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Hardwell")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count,1 , "found insted: \(cells.debugDescription)")
        cells.element(boundBy: 0).swipeLeft()
        cells.element(boundBy: 0).buttons["Delete"].tap()
        XCTAssertEqual(cells.count,0,  "found insted: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Events"].tap()
        app.navigationBars["Events in Town"].buttons["Favorites"].tap()
        sleep(1)
        
    }
    
    
    func testAddCancel() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Events in Town"].buttons["Favorites"].tap()
        XCTAssertEqual(cells.count,2 , "found instead: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Hardwell")
        app.alerts["New favorite performer"].buttons["Cancel"].tap()
        XCTAssertEqual(cells.count,2 , "found instead: \(cells.debugDescription)")
    }
    
    func testSearchBar() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        let emptyListTable = XCUIApplication().tables["Empty list"]
        emptyListTable.segmentedControls.children(matching: .button).matching(identifier: "Title").element(boundBy: 0).tap()
        emptyListTable.searchFields["Search"].typeText("London\r")
        app.keyboards.buttons["Search"].tap()
        cells.element(boundBy: 2).tap()
        app.navigationBars["Events"].buttons["Events"].tap()
        
    }
    
}

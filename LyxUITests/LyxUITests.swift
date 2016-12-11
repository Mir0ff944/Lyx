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
//        let app = XCUIApplication()
//        app.navigationBars["Events in town"].buttons["Favorites"].tap()
//        app.navigationBars["Favorites"].buttons["Add"].tap()
//        app.textFields["nameField"].tap()
//        app.textFields["nameField"].typeText("Hardwell")
//        app.alerts["New favorite performer"].buttons["Add"].tap()
//        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddFavorite() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Events in town"].buttons["Favorites"].tap()
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Hardwell")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count, 1, "found insted: \(cells.debugDescription)")
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Ariana")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count, 2, "found insted: \(cells.debugDescription)")
        XCTAssert(app.staticTexts["Ariana"].exists)
    }

    func testSwipeToDelete() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Events in town"].buttons["Favorites"].tap()
        app.navigationBars["Favorites"].buttons["Add"].tap()
        app.textFields["nameField"].tap()
        app.textFields["nameField"].typeText("Hardwell")
        app.alerts["New favorite performer"].buttons["Add"].tap()
        XCTAssertEqual(cells.count,1 , "found insted: \(cells.debugDescription)")
        cells.element(boundBy: 0).swipeLeft()
        cells.element(boundBy: 0).buttons["Delete"].tap()
        XCTAssertEqual(cells.count,0,  "found insted: \(cells.debugDescription)")
    }
    
    func testSearchBar() {
        let app = XCUIApplication()
        let cells = app.tables.cells
        app.navigationBars["Favorites"].buttons["Events"].tap()
        app.tables.searchFields["Search"].tap()
//        app.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Sofia")
        app.keyboards.buttons["Done"].tap()
        cells.element(boundBy: 0).tap()
        app.navigationBars["Events"].buttons["Favorites"].tap()
        
        
    }
    
}

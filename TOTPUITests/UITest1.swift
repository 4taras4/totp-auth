//
//  TOTPUITests.swift
//  TOTPUITests
//
//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import XCTest

class UITest1: XCTestCase {

    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
        continueAfterFailure = false
    }
    
    func testOne() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.buttons["Skip"].tap()
    }
   
    func testTwo() {
        let app = XCUIApplication()

        app.navigationBars["Accounts"].buttons["Add"].tap()
        let addButton = app.navigationBars["QR Scaner"].buttons["Add"]
        addButton.tap()
        
        let usernameGmailComTextField = app.textFields["username@gmail.com"]
        usernameGmailComTextField.tap()
        usernameGmailComTextField.typeText("test")
        app.staticTexts["Issuer:"].tap()
        
        let googleTextField = XCUIApplication().textFields["Google"]
        googleTextField.tap()
        googleTextField.typeText("test")
        app.staticTexts["Issuer:"].tap()
        
        
        let textField = app.textFields["***********"]
        textField.tap()
        textField.typeText("test")
        app.staticTexts["Issuer:"].tap()
        
        app.navigationBars["Add custom"].buttons["Save"].tap()
    }
    
    func testThree() {
        let tablesQuery = XCUIApplication().tables
        let invalidDataStaticText = tablesQuery.staticTexts["Invalid data"]
        invalidDataStaticText.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
    }
    
}

//
//  TOTPUITests.swift
//  TOTPUITests
//
//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import XCTest

class TOTPUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    func testUI() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.buttons["Skip"].tap()
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
        app.staticTexts["Token:"].tap()

        
        let textField = app.textFields["***********"]
        textField.tap()
        textField.typeText("test")
        app.navigationBars["Add custom"].buttons["Save"].tap()
        
        let tablesQuery = XCUIApplication().tables
        let invalidDataStaticText = tablesQuery.staticTexts["Invalid data"]
        invalidDataStaticText.swipeLeft()
        tablesQuery.buttons["Delete"].tap()

    }

}

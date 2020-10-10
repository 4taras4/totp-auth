//
//  MainListMainListPresenterTests.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class MainListPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: MainListInteractorInput {

    }

    class MockRouter: MainListRouterInput {

    }

    class MockViewController: MainListViewInput {

        func setupInitialState() {

        }
    }
}
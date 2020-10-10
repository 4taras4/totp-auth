//
//  MainListMainListContainerTests.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class MainListModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = MainListViewControllerMock()
        let presenter = container.resolve(MainListPresenter.self, argument: viewController as MainListViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "MainListViewController is nil after configuration")
        XCTAssertTrue(viewController.output is MainListPresenter, "output is not MainListPresenter")

        let presenter: MainListPresenter = viewController.output as! MainListPresenter
        XCTAssertNotNil(presenter.view, "view in MainListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in MainListPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is MainListRouter, "router is not MainListRouter")

        let interactor: MainListInteractor = presenter.interactor as! MainListInteractor
        XCTAssertNotNil(interactor.output, "output in MainListInteractor is nil after configuration")
    }

    class MainListViewControllerMock: MainListViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

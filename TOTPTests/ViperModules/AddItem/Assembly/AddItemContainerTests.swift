//
//  AddItemAddItemContainerTests.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class AddItemModuleConfiguratorTests: XCTestCase {

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
        let viewController = AddItemViewControllerMock()
        let presenter = container.resolve(AddItemPresenter.self, argument: viewController as AddItemViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "AddItemViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AddItemPresenter, "output is not AddItemPresenter")

        let presenter: AddItemPresenter = viewController.output as! AddItemPresenter
        XCTAssertNotNil(presenter.view, "view in AddItemPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AddItemPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AddItemRouter, "router is not AddItemRouter")

        let interactor: AddItemInteractor = presenter.interactor as! AddItemInteractor
        XCTAssertNotNil(interactor.output, "output in AddItemInteractor is nil after configuration")
    }

    class AddItemViewControllerMock: AddItemViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

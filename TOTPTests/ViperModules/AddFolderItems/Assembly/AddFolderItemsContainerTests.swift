//
//  AddFolderItemsAddFolderItemsContainerTests.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class AddFolderItemsModuleConfiguratorTests: XCTestCase {

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
        let viewController = AddFolderItemsViewControllerMock()
        let presenter = container.resolve(AddFolderItemsPresenter.self, argument: viewController as AddFolderItemsViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "AddFolderItemsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AddFolderItemsPresenter, "output is not AddFolderItemsPresenter")

        let presenter: AddFolderItemsPresenter = viewController.output as! AddFolderItemsPresenter
        XCTAssertNotNil(presenter.view, "view in AddFolderItemsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AddFolderItemsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AddFolderItemsRouter, "router is not AddFolderItemsRouter")

        let interactor: AddFolderItemsInteractor = presenter.interactor as! AddFolderItemsInteractor
        XCTAssertNotNil(interactor.output, "output in AddFolderItemsInteractor is nil after configuration")
    }

    class AddFolderItemsViewControllerMock: AddFolderItemsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

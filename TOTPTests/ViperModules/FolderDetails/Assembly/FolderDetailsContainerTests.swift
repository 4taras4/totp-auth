//
//  FolderDetailsFolderDetailsContainerTests.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class FolderDetailsModuleConfiguratorTests: XCTestCase {

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
        let viewController = FolderDetailsViewControllerMock()
        let presenter = container.resolve(FolderDetailsPresenter.self, argument: viewController as FolderDetailsViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "FolderDetailsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FolderDetailsPresenter, "output is not FolderDetailsPresenter")

        let presenter: FolderDetailsPresenter = viewController.output as! FolderDetailsPresenter
        XCTAssertNotNil(presenter.view, "view in FolderDetailsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FolderDetailsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FolderDetailsRouter, "router is not FolderDetailsRouter")

        let interactor: FolderDetailsInteractor = presenter.interactor as! FolderDetailsInteractor
        XCTAssertNotNil(interactor.output, "output in FolderDetailsInteractor is nil after configuration")
    }

    class FolderDetailsViewControllerMock: FolderDetailsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

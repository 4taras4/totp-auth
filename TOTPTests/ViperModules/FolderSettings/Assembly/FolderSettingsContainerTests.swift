//
//  FolderSettingsFolderSettingsContainerTests.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class FolderSettingsModuleConfiguratorTests: XCTestCase {

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
        let viewController = FolderSettingsViewControllerMock()
        let presenter = container.resolve(FolderSettingsPresenter.self, argument: viewController as FolderSettingsViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "FolderSettingsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is FolderSettingsPresenter, "output is not FolderSettingsPresenter")

        let presenter: FolderSettingsPresenter = viewController.output as! FolderSettingsPresenter
        XCTAssertNotNil(presenter.view, "view in FolderSettingsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in FolderSettingsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is FolderSettingsRouter, "router is not FolderSettingsRouter")

        let interactor: FolderSettingsInteractor = presenter.interactor as! FolderSettingsInteractor
        XCTAssertNotNil(interactor.output, "output in FolderSettingsInteractor is nil after configuration")
    }

    class FolderSettingsViewControllerMock: FolderSettingsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

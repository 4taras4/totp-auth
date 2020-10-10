//
//  SettingsSettingsContainerTests.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import XCTest
@testable import TOTP

class SettingsModuleConfiguratorTests: XCTestCase {

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
        let viewController = SettingsViewControllerMock()
        let presenter = container.resolve(SettingsPresenter.self, argument: viewController as SettingsViewController)!

        //when
        viewController.output = presenter

        //then
        XCTAssertNotNil(viewController.output, "SettingsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is SettingsPresenter, "output is not SettingsPresenter")

        let presenter: SettingsPresenter = viewController.output as! SettingsPresenter
        XCTAssertNotNil(presenter.view, "view in SettingsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in SettingsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is SettingsRouter, "router is not SettingsRouter")

        let interactor: SettingsInteractor = presenter.interactor as! SettingsInteractor
        XCTAssertNotNil(interactor.output, "output in SettingsInteractor is nil after configuration")
    }

    class SettingsViewControllerMock: SettingsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}

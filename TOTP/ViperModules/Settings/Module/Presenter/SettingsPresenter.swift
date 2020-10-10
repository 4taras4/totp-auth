//
//  SettingsSettingsPresenter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

final class SettingsPresenter: SettingsViewOutput {

    // MARK: -
    // MARK: Properties

    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!

    // MARK: -
    // MARK: SettingsViewOutput
    func viewIsReady() {

    }

}

// MARK: -
// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}

// MARK: -
// MARK: SettingsModuleInput
extension SettingsPresenter: SettingsModuleInput {

}

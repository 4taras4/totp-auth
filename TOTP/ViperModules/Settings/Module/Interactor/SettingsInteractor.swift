//
//  SettingsSettingsInteractor.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit
    
final class SettingsInteractor: SettingsInteractorInput {

	weak var output: SettingsInteractorOutput!

    func setBlur(isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: Constants.settings.blur)
        AppDelegate.autoBlur.isAutoBlur = isEnabled
    }
}

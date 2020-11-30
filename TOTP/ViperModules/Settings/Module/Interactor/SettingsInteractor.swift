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
    
    func setBiometric(isEnabled: Bool) {
        if isEnabled {
            BiometricsManager.shared.showAuthIfNeeded()
        }
        UserDefaults.standard.set(isEnabled, forKey: Constants.settings.biometric)
        BiometricsManager.shared.biometricEnabled = isEnabled
    }
    
    func createBackup() {
        do {
            try RealmManager.shared.uploadDatabaseToCloudDrive()
            output.backupCreated()
        } catch let error {
            output.errorProcessing(error: error.localizedDescription)
        }
    }
    
    func restoreFromBackup() {
        do {
            try RealmManager.shared.downloadDatabaseFromCloudDrive()
            output!.restoredFromBackup()
        } catch let error {
            output.errorProcessing(error: error.localizedDescription)
        }
    }
    
}

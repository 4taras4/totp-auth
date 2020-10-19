//
//  SettingsSettingsViewInput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

protocol SettingsViewInput: class {
	/// - author: Tarik
	func setupInitialState()
    
    func mailUnavailable()
    
    func setSwitch(isEnabled: Bool)
    
    func showAlert(error: String)
    
    func backupCreated()
    
    func restoredFromBackup()
}

//
//  SettingsSettingsViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBAction func blurSwitchAction(_ sender: Any) {
        output.blurSetting(isEnabled: blurSwitch.isOn)
    }
    @IBOutlet weak var blurSwitch: UISwitch!
    @IBAction func biometricSwitchAction(_ sender: Any) {
        output.biometricSetting(isEnabled: biometricSwitch.isOn)
    }
    @IBOutlet weak var biometricSwitch: UISwitch!
    // MARK: -
	// MARK: Properties
	var output: SettingsViewOutput!

	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        tableView.delegate = output
	}

}

// MARK: -
// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {
    func showAlert(error: String) {
        UIManager.shared.showAlert(title: Constants.text.settingsErrorAlertTitle, message: error)
    }
    
    func backupCreated() {
        UIManager.shared.showAlert(title: Constants.text.settingsSuccessAlertTitle, message: Constants.text.settingsSuccessBackupDataCreatedAlertDescription)
    }
    
    func restoredFromBackup() {
        UIManager.shared.showAlert(title: Constants.text.settingsSuccessAlertTitle, message: Constants.text.settingsSuccessRestoredDataAlertDescription)
    }
    
    func setBlurSwitch(isEnabled: Bool) {
        blurSwitch.setOn(isEnabled, animated: false)
    }
    
    func setBiometricSwitch(isEnabled: Bool) {
        biometricSwitch.setOn(isEnabled, animated: false)
    }
    
    func mailUnavailable() {
        UIManager.shared.showAlert(title: Constants.text.settingsErrorAlertTitle, message: Constants.text.settingsMailUnavailableAlertDescription)
    }
    
	func setupInitialState() {

	}

}


extension SettingsViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "SettingsViewController"
    }
}

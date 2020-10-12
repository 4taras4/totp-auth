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
    func setSwitch(isEnabled: Bool) {
        blurSwitch.setOn(isEnabled, animated: false)
    }
    
    func mailUnavailable() {
        UIManager.shared.showAlert(title: "Error", message: "Mail client unavailable. Please login to native Mail client to send message")
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

//
//  SettingsSettingsViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: SettingsViewOutput!

	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
	}

}

// MARK: -
// MARK: SettingsViewInput
extension SettingsViewController: SettingsViewInput {

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

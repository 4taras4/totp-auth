//
//  SettingsSettingsViewOutput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

protocol SettingsViewOutput: class, UITableViewDelegate {
	/// - author: Tarik
	func viewIsReady()
    
    func blurSetting(isEnabled: Bool)
}

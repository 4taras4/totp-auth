//
//  FolderSettingsFolderSettingsViewOutput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import UIKit

protocol FolderSettingsViewOutput: class, UITableViewDelegate, UITableViewDataSource {
	/// - author: Tarik
	func viewIsReady()
        
    func editButtonPressed()
    
}

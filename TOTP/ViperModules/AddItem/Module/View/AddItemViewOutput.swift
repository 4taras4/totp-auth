//
//  AddItemAddItemViewOutput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

protocol AddItemViewOutput: class {
	/// - author: Tarik
	func viewIsReady()
    
    func setTokenUrl(string: String)
    
    func setManualyPressed()
    
    func cameraSettingsPressed()
}

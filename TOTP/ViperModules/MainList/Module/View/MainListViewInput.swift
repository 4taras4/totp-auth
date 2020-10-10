//
//  MainListMainListViewInput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

protocol MainListViewInput: class {
	/// - author: Tarik
	func setupInitialState()
    
    func reloadTable()

}

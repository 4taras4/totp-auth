//
//  AddFolderItemsAddFolderItemsViewInput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

protocol AddFolderItemsViewInput: class {
	/// - author: Tarik
	func setupInitialState()
    
    func reloadTable()
    
    func showError(error: Error)
}

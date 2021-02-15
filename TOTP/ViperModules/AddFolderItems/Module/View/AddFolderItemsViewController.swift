//
//  AddFolderItemsAddFolderItemsViewController.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit

class AddFolderItemsViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: AddFolderItemsViewOutput!

	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
	}

}

// MARK: -
// MARK: AddFolderItemsViewInput
extension AddFolderItemsViewController: AddFolderItemsViewInput {

	func setupInitialState() {

	}

}

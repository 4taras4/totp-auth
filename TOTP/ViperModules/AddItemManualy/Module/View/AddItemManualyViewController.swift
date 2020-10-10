//
//  AddItemManualyAddItemManualyViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class AddItemManualyViewController: UIViewController {

	// MARK: -
	// MARK: Properties
	var output: AddItemManualyViewOutput!

	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
	}

}

// MARK: -
// MARK: AddItemManualyViewInput
extension AddItemManualyViewController: AddItemManualyViewInput {

	func setupInitialState() {

	}

}

extension AddItemManualyViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "AddItemManualyViewController"
    }
}

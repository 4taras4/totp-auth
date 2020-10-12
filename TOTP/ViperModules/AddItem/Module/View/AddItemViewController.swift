//
//  AddItemAddItemViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

	// MARK: -
	// MARK: Properties
	var output: AddItemViewOutput!

    @IBAction func addManualyAction(_ sender: Any) {
        output.setManualyPressed()
    }
    @IBOutlet weak var cameraView: CameraView!
    
    // MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        cameraView.delegate = self
	}

}

// MARK: -
// MARK: AddItemViewInput
extension AddItemViewController: AddItemViewInput {
    func failedSaveData() {
        UIManager.shared.showAlert(title: "Error", message: "Can't add token")
    }
    

	func setupInitialState() {

	}
}

extension AddItemViewController: CameraCaptureDelegate {
    func capture(string: String?) {
        print("rq code data: \(String(describing: string))")
        guard let unwrapedString = string else {
            return
        }
        output.setTokenUrl(string: unwrapedString)
    }
}


extension AddItemViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "AddItemViewController"
    }
}

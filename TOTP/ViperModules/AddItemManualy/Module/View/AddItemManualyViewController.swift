//
//  AddItemManualyAddItemManualyViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class AddItemManualyViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: AddItemManualyViewOutput!

    @IBAction func saveAction(_ sender: Any) {
        output.save()
    }
    @IBOutlet weak var issuerTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secretTextField: UITextField!
    // MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        issuerTextField.delegate = self
        nameTextField.delegate = self
        secretTextField.delegate = self
	}

}

extension AddItemManualyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case issuerTextField:
           if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                output.viewWantsToUpdate(issuer: updatedText)
            }
            return true
        case nameTextField:
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                output.viewWantsToUpdate(name: updatedText)
            }
            return true
        case secretTextField:
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                output.viewWantsToUpdate(secret: updatedText)
            }
            return true
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
           case secretTextField:
               output.viewWantsToUpdate(secret: textField.text!)
           case nameTextField:
               output.viewWantsToUpdate(name: textField.text!)
        case issuerTextField:
            output.viewWantsToUpdate(issuer: textField.text!)
           default:
               break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
           case secretTextField:
                nameTextField!.becomeFirstResponder()
           case nameTextField:
                issuerTextField.becomeFirstResponder()
           case issuerTextField:
                print("Done pressed")
                textField.resignFirstResponder()
                output.save()
           default:
               break
        }
       return true
    }
}

// MARK: -
// MARK: AddItemManualyViewInput
extension AddItemManualyViewController: AddItemManualyViewInput {
    func errorValidation() {
        UIManager.shared.showAlert(title: "Error", message: "SECRET and NAME fields should be filled")
    }
    

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

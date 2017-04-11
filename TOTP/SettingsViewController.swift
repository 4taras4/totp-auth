//
//  SettingsViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 4/11/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
   
    @IBOutlet weak var passwordSwitcher: UISwitch!
    let defaults = UserDefaults.standard
    var valid = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func passwordAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let password = UIAlertAction(title: "Confirm", style: .default) { (_) in
                var pass: String?
                var confPass: String?
                pass = alertController.textFields?[0].text
                print(pass! )
                confPass = alertController.textFields?[1].text
                self.isValid(lhs: pass!, rhs: confPass!)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField {(textField) in
                textField.placeholder = "Input password here"
                textField.isSecureTextEntry = true
                textField.keyboardType = UIKeyboardType.numberPad
                textField.keyboardAppearance = UIKeyboardAppearance.dark
            }
            
            alertController.addTextField {(textField) in
                textField.placeholder = "Repeat please"
                textField.isSecureTextEntry = true
                textField.keyboardType = UIKeyboardType.numberPad
                textField.keyboardAppearance = UIKeyboardAppearance.dark
            }
            alertController.addAction(password)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func isValid(lhs: String, rhs: String) -> Bool {
        if lhs == rhs {
            print("Valid")
            defaults.set(lhs, forKey: "launchPass")
            defaults.synchronize()
            self.noticeSuccess("Saved", autoClear: true, autoClearTime: 1)
            return true
        }
        print("Invalid")
        passwordAlert(title: "Error", message: "Different password, please try again")
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && indexPath.row == 0 ) {
            passwordAlert(title: "Setup password", message: "Please input password")
        }
    }
}


//
//  ManualUserViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 24.03.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Crashlytics
class ManualUserViewController: UIViewController {
    var name:String?
    var issuer:String?
    var token:String?
    //MARK: Actions

    @IBAction func saveToDBAction(_ sender: Any) {
        guard let nameString = self.nameField.text else {
            return
        }
        guard let issueString = self.issuerFiled.text else {
            return
        }
        guard let tokenString = self.tokenField.text else {
            return
        }
        if nameString.count > 1 && issueString.count > 1 && tokenString.count > 1 {
            RealmData.saveToDB(name: nameString, issuer: issueString, token: tokenString)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Main")
            self.present(controller, animated: false, completion: nil)
            Answers.logContentView(withName: "Save custom token", contentType: "Button", contentId: "customToken", customAttributes: ["Favorites Count":30, "Screen Orientation":"Portrait"])
        } else {
            Alert.showAlert(title: "Error", message: "Some fields is empty. Please fill all fields")
        }
    }
 
    
    //MARK: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var issuerFiled: UITextField!
    @IBOutlet weak var tokenField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

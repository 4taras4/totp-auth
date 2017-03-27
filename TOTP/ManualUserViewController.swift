//
//  ManualUserViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 24.03.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class ManualUserViewController: UIViewController {
    var name:String?
    var issuer:String?
    var token:String?
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        RealmData.saveToDB(name: name, issuer: issuer, token: token)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
    }
    
    //MARK: Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var issuerFiled: UITextField!
    @IBOutlet weak var tokenField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let nameString = nameField.text else {
            return
        }
        guard let issueString = nameField.text else {
            return
        }
        guard let tokenString = nameField.text else {
            return
        }
        name = nameString
        issuer = issueString
        token = tokenString
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

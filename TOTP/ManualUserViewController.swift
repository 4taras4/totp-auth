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
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: Any) {
        RealmData.saveToDB(name: name, issuer: issuer, token: token)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
    }
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

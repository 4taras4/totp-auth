//
//  SettingsViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 4/11/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Crashlytics
class SettingsViewController: UITableViewController {
   
  
    @IBAction func zipAction(_ sender: Any) {
        Backup.createBackup()
    }
    @IBAction func unzipAction(_ sender: Any) {
        Backup.unzipBackup()
    }
    
    @IBOutlet weak var passwordSwitcher: UISwitch!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        getButtonState()
        passwordSwitcher.addTarget(self, action: #selector(switchAction(_:)), for: UIControlEvents.valueChanged)

    }
    
    func switchAction(_ passwordSwitcher: UISwitch) {
        if passwordSwitcher.isOn{
            Answers.logContentView(withName: "Use touchID", contentType: "Button", contentId: "tIDOn", customAttributes: ["Favorites Count":40, "Screen Orientation":"Portrait"])
            SecurityAuth.loadSecurityAlert(isOn:true)
            passwordSwitcher.setOn(true, animated: true)
        } else {
            Answers.logContentView(withName: "Use touchID", contentType: "Button", contentId: "tIDOf", customAttributes: ["Favorites Count":40, "Screen Orientation":"Portrait"])
            SecurityAuth.loadSecurityAlert(isOn:false)
            passwordSwitcher.setOn(false, animated: true)
        }
    }
    
    func getButtonState() {
        let state = defaults.object(forKey: "touchID") as! String? ?? "0"
        if state == "1" {
            passwordSwitcher.setOn(true, animated: true)
        } else {
            passwordSwitcher.setOn(false, animated: true)
        }
    }
}


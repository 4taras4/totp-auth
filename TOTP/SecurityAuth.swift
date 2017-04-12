//
//  SecurityAuth.swift
//  TOTP
//
//  Created by Taras Markevych on 4/12/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class SecurityAuth {
    static let defaults = UserDefaults.standard
   
    static func loadSecurityAlert(isOn: Bool) -> Bool {
        if isOn == true {
            defaults.set("1", forKey: "touchID")
            defaults.synchronize()
            return true
        } else {
            defaults.set("0", forKey: "touchID")
            defaults.synchronize()
            return false
        }
    }
}

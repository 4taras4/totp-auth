//
//  Alert.swift
//  TOTP
//
//  Created by Taras Markevych on 4/19/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class Alert {

    class func showAlert(title: String?, message: String?) {
        let alert = UIAlertView()
        alert.title = title ?? ""
        alert.message = message ?? ""
        alert.addButton(withTitle: "Ok")
        alert.show()
    }
}

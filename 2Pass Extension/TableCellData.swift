//
//  TableCellData.swift
//  TOTP
//
//  Created by Taras Markevych on 4/6/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import WatchKit
import RealmSwift

class TableCellData: NSObject {

    @IBOutlet var usernameLabel: WKInterfaceLabel!
    @IBOutlet var passcodeLabel: WKInterfaceLabel!
//    var data: Results<User>? {
//        didSet {
//            if let data = data {
//                usernameLabel.setText(data.first?.name)
//                let token = TOTPApi.sharedInstance.refreshToken(name: data.first?.name, issuer:  data.first?.issuer, secretData: data.first?.token)
//                print(token)
//                passcodeLabel.setText(token)
//            }
//        }
//    }
}

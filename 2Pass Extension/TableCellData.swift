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
    @IBOutlet var issuerLabel: WKInterfaceLabel!

}

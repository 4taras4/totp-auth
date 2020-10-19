//
//  CodeTableViewRow.swift
//  TwoPass Extension
//
//  Created by Taras Markevych on 20.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WatchKit

class CodeTableViewRow: NSObject {
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var codeLabel: WKInterfaceLabel!
    @IBOutlet weak var issuerLabel: WKInterfaceLabel!

    func setup(cell: Code) {
        codeLabel.setText(cell.code)
        nameLabel.setText(cell.name)
        issuerLabel.setText(cell.issuer)
    }
}

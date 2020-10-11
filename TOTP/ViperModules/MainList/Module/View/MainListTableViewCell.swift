//
//  MainListTableViewCell.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

class MainListTableViewCell: UITableViewCell {

    @IBOutlet weak var timeProgressView: UIProgressView!
    @IBOutlet weak var issuerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var digitsLabel: UILabel!
    var refreshTimer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(cell code: Code, timeInterval: TimeInterval) {
        issuerLabel.text = code.issuer
        nameLabel.text = code.name
        digitsLabel.text = code.code.applyPatternOnNumbers(pattern: "### ###", replacmentCharacter: "#")
        timeProgressView.setProgress(0.0, animated: true)
        UIView.animate(withDuration: timeInterval, animations: {
            self.timeProgressView.setProgress(1.0, animated: true)
        })
    }

}

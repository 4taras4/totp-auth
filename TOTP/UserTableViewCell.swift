//
//  UserTableViewCell.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var passCode: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var issuer: UILabel!
    @IBOutlet weak var timer: Circle!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

     override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

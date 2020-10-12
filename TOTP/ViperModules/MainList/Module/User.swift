//
//  User.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import RealmSwift

public class User: Object {
    @objc dynamic var name: String?
    @objc dynamic var issuer: String?
    @objc dynamic var token: String?
    
    override public static func primaryKey() -> String? {
        return "token"
    }
}

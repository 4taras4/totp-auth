//
//  Folder.swift
//  TOTP
//
//  Created by Taras Markevych on 13.02.2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit
import RealmSwift

class Folder: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl: String = ""
    var codes = List<User>()

    override public static func primaryKey() -> String {
        return "id"
    }
}

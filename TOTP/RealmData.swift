//
//  RealmData.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import RealmSwift

class RealmData {
    
   static func saveToDB(name:String?, issuer:String?, token:String?) {
        do {
            let realm = try Realm()
            let newUser = User()
            newUser.name = name
            newUser.issuer = issuer
            newUser.token = token
            try realm.write {
                realm.add(newUser, update: true)
            }
        } catch {
            print(Error.self)
        }
    }
    
}

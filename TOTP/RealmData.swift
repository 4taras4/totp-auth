//
//  RealmData.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
   
    func saveNewUser(name:String?, issuer:String?, token:String, completionHandler: @escaping((Bool)->())) {
        do {
            let realm = try Realm()
            let newUser = User()
            newUser.name = name
            newUser.issuer = issuer
            newUser.token = token
            try realm.write {
                realm.add(newUser, update: .all)
                completionHandler(true)
            }
        } catch {
            print("Can't add user")
            completionHandler(false)
        }
    }
    
    func fetchCodesList() -> [User]? {
        var userList: Results<User>?
        do {
            let realm = try Realm()
            userList = realm.objects(User.self)
            return userList?.toArray()
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func removeObject(user: User, completionHandler: @escaping((Bool)->())) {
        do {
            let realm = try Realm()
            realm.delete(user)
            completionHandler(true)
        } catch let error {
            print(error)
            completionHandler(false)
        }
    }
}


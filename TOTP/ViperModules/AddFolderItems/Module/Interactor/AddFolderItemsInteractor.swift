//
//  AddFolderItemsAddFolderItemsInteractor.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import RealmSwift

final class AddFolderItemsInteractor: AddFolderItemsInteractorInput {

	weak var output: AddFolderItemsInteractorOutput!

    func getAllAccounts() {
        var userList: List<User>?
        do {
            let realm = try Realm()
            userList = realm.list(User.self)
            output.getAllAccounts(list: userList)
        } catch let error {
            print(error)
            output.getAccountsError(error: error)
        }
    }
    
    func addOrRemove(item: User, for list: List<User>) {
        do {
            var localList = list
            let realm = try Realm()
            if list.contains(item) {
                if let index = localList.index(of: item) {
                    try realm.write({
                        localList.remove(at: index)
                    })
                }
            } else {
                try realm.write({
                    localList.append(item)
                })
            }
            output.updatedSelected(list: localList)
        } catch let error {
            print(error)
            output.getAccountsError(error: error)
        }
    }


}

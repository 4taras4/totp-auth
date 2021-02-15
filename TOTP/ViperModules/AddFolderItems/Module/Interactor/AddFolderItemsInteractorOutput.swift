//
//  AddFolderItemsAddFolderItemsInteractorOutput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation
import RealmSwift

protocol AddFolderItemsInteractorOutput: class {
    func getAllAccounts(list: List<User>?)
    func getAccountsError(error: Error)
    func updatedSelected(list: List<User>)
}

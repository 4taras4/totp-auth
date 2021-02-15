//
//  AddFolderItemsAddFolderItemsInteractorInput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation
import RealmSwift
protocol AddFolderItemsInteractorInput: class {
    func getAllAccounts()
    
    func addOrRemove(item: User,  for list: List<User>)
}

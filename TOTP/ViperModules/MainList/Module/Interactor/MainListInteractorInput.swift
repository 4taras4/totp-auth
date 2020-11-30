//
//  MainListMainListInteractorInput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation

protocol MainListInteractorInput: class {
    func converUserData(users: [User])
    func deleteRow(with token: String?)
    func updateRow(with token: String?, isFavourite: Bool)

}

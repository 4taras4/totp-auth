//
//  FolderDetailsFolderDetailsInteractorInput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation

protocol FolderDetailsInteractorInput: class {
    func converUserData(users: [User])
}

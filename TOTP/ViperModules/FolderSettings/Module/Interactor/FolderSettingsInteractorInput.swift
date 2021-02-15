//
//  FolderSettingsFolderSettingsInteractorInput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation

protocol FolderSettingsInteractorInput: class {
    func getFoldersArray()
    func createFolder(with name: String)
    func removeFolder(item: Folder)
}

//
//  FolderSettingsFolderSettingsInteractorOutput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation

protocol FolderSettingsInteractorOutput: class {
    func getFolders(array: [Folder])
    
    func folderAddedSuccess()
    
    func folderAddedFailure(error: Error)
    
    func folderRemoved()
    
    func folderRemovingFailure(error: Error)
}

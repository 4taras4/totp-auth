//
//  FolderSettingsFolderSettingsInteractor.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

final class FolderSettingsInteractor: FolderSettingsInteractorInput {
    
	weak var output: FolderSettingsInteractorOutput!
    
    func getFoldersArray() {
        output.getFolders(array: RealmManager.shared.fetchFolders() ?? [])
    }

    func createFolder(with name: String) {
        RealmManager.shared.createFolder(name: name, completionHandler: { [weak self] result in
            switch result {
            case .success(_):
                self?.output.folderAddedSuccess()
            case .failure(let error):
                self?.output.folderAddedFailure(error: error)
            }
        })
    }
    
    func removeFolder(item: Folder) {
        RealmManager.shared.removeFolder(folder: item) { [weak self] result in
            switch result {
            case .success(_):
                self?.output.folderRemoved()
            case .failure(let error):
                self?.output.folderRemovingFailure(error: error)
            }
        }
    }
}

//
//  FolderSettingsFolderSettingsPresenter.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import UIKit
import RealmSwift

final class FolderSettingsPresenter: NSObject, FolderSettingsViewOutput {
   
    // MARK: -
    // MARK: Properties

    weak var view: FolderSettingsViewInput!
    var interactor: FolderSettingsInteractorInput!
    var router: FolderSettingsRouterInput!
    fileprivate var folders = [Folder]()
    fileprivate var addFolerItem = Folder()
    // MARK: -
    // MARK: FolderSettingsViewOutput
    func viewIsReady() {
        addFolerItem.name = Constants.text.addNewItemText
        interactor.getFoldersArray()
    }
    
    func editButtonPressed() {
        view.changeIsEdit()
    }
}

// MARK: -
// MARK: FolderSettingsInteractorOutput
extension FolderSettingsPresenter: FolderSettingsInteractorOutput {
    func folderRemoved() {
        interactor.getFoldersArray()
    }
    
    func folderRemovingFailure(error: Error) {
        view.showError(error: error.localizedDescription)
    }
    
    func getFolders(array: [Folder]) {
        folders = array
        folders.append(addFolerItem)
        view.reloadTable()
    }
    
    func folderAddedSuccess() {
        interactor.getFoldersArray()
    }
    
    func folderAddedFailure(error: Error) {
        view.showError(error: error.localizedDescription)
    }
}

// MARK: -
// MARK: FolderSettingsModuleInput
extension FolderSettingsPresenter: FolderSettingsModuleInput {

}

extension FolderSettingsPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) 
        cell.textLabel?.text = folders[indexPath.row].name
        if indexPath.row == folders.count - 1 {
            cell.textLabel?.textColor = .systemIndigo
        } else {
            cell.textLabel?.textColor = .label
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == folders.count - 1 {
            showCreateFolderAlert()
        } else {
            router.openSettings(for: folders[indexPath.row])
        }
    }
    
    
    fileprivate func showCreateFolderAlert() {
        let alert = UIAlertController(title: Constants.text.folderNameTitle, message: Constants.text.folderNameDescription, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = Constants.text.folderNamePlaceholder
        }
        alert.addAction(UIAlertAction(title: Constants.text.cancelAlertButton, style: .destructive, handler: { (_) in
          
        }))
        alert.addAction(UIAlertAction(title: Constants.text.createAlertButton, style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            self.interactor.createFolder(with: textField!.text!)
        }))
        
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.text.folderHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor.removeFolder(item: folders[indexPath.row])
        } 
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == folders.count - 1 {
            return .none
        }
        return .delete
    }
}

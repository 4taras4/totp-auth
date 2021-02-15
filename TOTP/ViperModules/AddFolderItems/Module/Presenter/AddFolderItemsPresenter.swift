//
//  AddFolderItemsAddFolderItemsPresenter.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import UIKit
import RealmSwift
final class AddFolderItemsPresenter: NSObject , AddFolderItemsViewOutput {
    

    // MARK: -
    // MARK: Properties

    weak var view: AddFolderItemsViewInput!
    var interactor: AddFolderItemsInteractorInput!
    var router: AddFolderItemsRouterInput!
    var allAccounts: List<User>?
    var selectedAccounts: List<User>?
    var folderName = ""
    // MARK: -
    // MARK: AddFolderItemsViewOutput
    func viewIsReady() {
        view.reloadTable()

    }

}

// MARK: -
// MARK: AddFolderItemsInteractorOutput
extension AddFolderItemsPresenter: AddFolderItemsInteractorOutput {
    func updatedSelected(list: List<User>) {
        selectedAccounts = list
        view.reloadTable()
    }
    
    func getAllAccounts(list: List<User>?) {
        allAccounts = list
    }
    
    func getAccountsError(error: Error) {
        view.showError(error: error)
    }
}

// MARK: -
// MARK: AddFolderItemsModuleInput
extension AddFolderItemsPresenter: AddFolderItemsModuleInput, UITableViewDelegate, UITableViewDataSource {
    func addItemsFor(folder: Folder) {
        folderName = folder.name
        selectedAccounts = folder.codes
        if selectedAccounts == nil {
            selectedAccounts = List<User>()
        }
        interactor.getAllAccounts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAccounts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountItemCell", for: indexPath)
        guard let item = allAccounts?[indexPath.row] , let selected = selectedAccounts else { return cell }
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.
        if selected.contains(item) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = allAccounts?[indexPath.row], let selected = selectedAccounts {
            interactor.addOrRemove(item: item, for: selected)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select account which you wish to add on \(folderName) folder"
    }
}

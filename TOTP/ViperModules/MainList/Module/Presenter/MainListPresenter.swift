//
//  MainListMainListPresenter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

final class MainListPresenter: NSObject, MainListViewOutput {
    // MARK: -
    // MARK: Properties

    weak var view: MainListViewInput!
    var interactor: MainListInteractorInput!
    var router: MainListRouterInput!
    var codeList = [Code]()
    var refreshTimer: Timer?

    // MARK: -
    // MARK: MainListViewOutput
    func viewIsReady() {
        refreshTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        interactor.converUserData(users: RealmManager.shared.fetchCodesList() ?? [])
    }

    func settingsButtonPressed() {
        router.openSettings()
    }
    
    func addItemButtonPressed() {
        router.addItem()
    }
    
    @objc func refreshData() {
        interactor.converUserData(users: RealmManager.shared.fetchCodesList() ?? [])
    }
    
}

// MARK: -
// MARK: MainListInteractorOutput
extension MainListPresenter: MainListInteractorOutput {
    func listOfCodes(codes: [Code]) {
        codeList = codes
        view.reloadTable()
    }
}

// MARK: -
// MARK: MainListModuleInput
extension MainListPresenter: MainListModuleInput {

}

extension MainListPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        cell.setup(cell: codeList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = codeList[indexPath.row].code
        UIManager.shared.showAlert(title: nil, message: "Code \(codeList[indexPath.row].code) copied!")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
           self.deleteRowAtIndexPath(indexPath: indexPath)
       }
       return [delete]
   }
    
    private func deleteRowAtIndexPath(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Remove selected account", message: "if you remove account it's will be deleted permamently", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
            let array = RealmManager.shared.fetchCodesList() ?? []
            RealmManager.shared.removeObject(user: array[indexPath.row], completionHandler: { success in
                if success {
                    self.refreshData()
                }
            })
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        if let topController = UIApplication.topViewController() {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}

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
    var favouriteList = [Code]()

    var refreshTimer: Timer?
    var interval = 30.0
    var updated: Int = 0
    // MARK: -
    // MARK: MainListViewOutput
    func viewIsReady() {
        updated = 0
        let calendar = Calendar.current
        let time = calendar.dateComponents([.second], from: Date()).second!
        if time > 30 {
            interval = Double(60 - time)
        } else {
            interval = Double(30 - time)
        }
        print("init:", interval)
        refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }

    func settingsButtonPressed() {
        router.openSettings()
    }
    
    func addItemButtonPressed() {
        router.addItem()
    }
    
    func favItemButtonPressed() {
        view.changeIsEdit()
    }
    
    @objc func refreshData() {
        print(RealmManager.shared.fetchCodesList())
        interactor.converUserData(users: RealmManager.shared.fetchCodesList() ?? [])
    }
    
    func updateTimerIfNeeded() {
        updated += 1
        if interval != 30.0, updated == 2 {
            print("set new time")
            self.interval = 30
            refreshTimer?.invalidate()
            refreshTimer = nil
            refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        }
    }
}

// MARK: -
// MARK: MainListInteractorOutput
extension MainListPresenter: MainListInteractorOutput {
    func listOfCodes(codes: [Code], favourites: [Code]) {
        favouriteList = favourites
        codeList = codes
        view.reloadTable()
        updateTimerIfNeeded()
    }
}

// MARK: -
// MARK: MainListModuleInput
extension MainListPresenter: MainListModuleInput {

}

extension MainListPresenter: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return favouriteList.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favouriteList.isEmpty {
            return codeList.count
        } else {
            switch section {
            case 0:
                return favouriteList.count
            default:
                return codeList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        if favouriteList.isEmpty {
            cell.setup(cell: codeList[indexPath.row], timeInterval: interval)
        } else {
            switch indexPath.section {
            case 0:
                cell.setup(cell: favouriteList[indexPath.row], timeInterval: interval)
            default:
                cell.setup(cell: codeList[indexPath.row], timeInterval: interval)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = codeList[indexPath.row].code
        UIManager.shared.showAlert(title: nil, message: "Code \(codeList[indexPath.row].code) copied!")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if favouriteList.isEmpty {
            switch editingStyle {
            case .delete:
                deleteRowAtIndexPath(indexPath: indexPath)
            case .insert:
                updateRowAtIndexPath(indexPath: indexPath, isFavourite: true)
            default:
                break
            }
        } else {
            switch indexPath.section {
            case 0:
                switch editingStyle {
                case .delete:
                    updateRowAtIndexPath(indexPath: indexPath, isFavourite: false)
                case .insert:
                    updateRowAtIndexPath(indexPath: indexPath, isFavourite: true)
                default:
                    break
                }
            case 1:
                switch editingStyle {
                case .delete:
                    deleteRowAtIndexPath(indexPath: indexPath)
                case .insert:
                    updateRowAtIndexPath(indexPath: indexPath, isFavourite: true)
                default:
                    break
                }
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if favouriteList.isEmpty {
            return tableView.isEditing ? .insert : .delete
        } else {
            switch indexPath.section {
            case 0:
                return .delete
            case 1:
                return tableView.isEditing ? .insert : .delete
            default:
                return tableView.isEditing ? .insert : .delete
            }
        }
    }
    
    private func deleteRowAtIndexPath(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Remove selected account", message: "if you remove account it's will be deleted permamently", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Remove", style: .destructive, handler: { _ in
            guard let item = RealmManager.shared.getUserBy(token: self.codeList[indexPath.row].token) else { return }
            RealmManager.shared.removeObject(user: item, completionHandler: { success in
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
    
    
    private func updateRowAtIndexPath(indexPath: IndexPath, isFavourite: Bool = false) {
        guard let item = RealmManager.shared.getUserBy(token: self.codeList[indexPath.row].token) else { return }
        RealmManager.shared.saveNewUser(name: item.name, issuer: item.issuer, token: item.token ?? "", isFav: isFavourite, completionHandler: { completed in
            if completed {
                self.refreshData()
            }
        })
    }
    //added for ADDS baner spacing when you have a lot of items in the list
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        default:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if favouriteList.isEmpty {
            return nil
        } else {
            switch section {
            case 0:
                return "Favourites"
            default:
                return "Full List"
            }
        }
    }
}

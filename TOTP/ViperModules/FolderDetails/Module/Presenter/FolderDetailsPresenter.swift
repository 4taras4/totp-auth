//
//  FolderDetailsFolderDetailsPresenter.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import UIKit

final class FolderDetailsPresenter: NSObject, FolderDetailsViewOutput {
   
    // MARK: -
    // MARK: Properties

    weak var view: FolderDetailsViewInput!
    var interactor: FolderDetailsInteractorInput!
    var router: FolderDetailsRouterInput!
   
    private var refreshTimer: Timer?
    private var interval = 30.0
    private var updated: Int = 0
    
    fileprivate var selectedFolder: Folder!
    fileprivate var codeList = [Code]()

    // MARK: -
    // MARK: FolderDetailsViewOutput
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
    
    @objc func refreshData() {
        interactor.converUserData(users: Array(selectedFolder.codes))
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
    
    func invalidateTimer() {
        refreshTimer?.invalidate()
        refreshTimer = nil
        
    }
    
}

// MARK: -
// MARK: FolderDetailsInteractorOutput
extension FolderDetailsPresenter: FolderDetailsInteractorOutput {
    func listOfCodes(codes: [Code]) {
        codeList = codes
        view.reloadTable()
        updateTimerIfNeeded()
    }
    

}

// MARK: -
// MARK: FolderDetailsModuleInput
extension FolderDetailsPresenter: FolderDetailsModuleInput {
    func setFolder(item: Folder) {
        selectedFolder = item
        view.setTitle(string: item.name)
    }

}

extension FolderDetailsPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCell", for: indexPath) as! MainListTableViewCell
        cell.setup(cell: codeList[indexPath.row], timeInterval: interval)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIPasteboard.general.string = codeList[indexPath.row].code
        UIManager.shared.showAlert(title: nil, message: "Code \(codeList[indexPath.row].code) copied!")
    }
}

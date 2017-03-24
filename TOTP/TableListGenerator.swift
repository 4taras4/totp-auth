//
//  TableListGenerator.swift
//  TOTP
//
//  Created by Taras Markevych on 3/23/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import RealmSwift
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lists = userList {
            return lists.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let person = userList[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! UserTableViewCell
            cell.username.text = person.name
            cell.issuer.text = person.issuer
            let token = TOTPApi.sharedInstance.refreshToken(name: person.name!, issuer: person.issuer!, secretData: person.token!)
            cell.passCode.text = token
            return cell
    }
}

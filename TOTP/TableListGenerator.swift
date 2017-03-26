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
            if token != "invalid code" {
                let width = UIScreen.main.bounds.width
                let circleView = Circle(frame: CGRect(x:width - 60, y:40, width: 40, height: 40))
                cell.addSubview(circleView)
                circleView.animateCircle(duration: 30.0)
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = userList[indexPath.row]
        let token = TOTPApi.sharedInstance.refreshToken(name: person.name!, issuer: person.issuer!, secretData: person.token!)
        UIPasteboard.general.string = token
        self.noticeSuccess("Copied!", autoClear: true, autoClearTime: 1)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteRowAtIndexPath(indexPath: indexPath as NSIndexPath)
            
        }
        return [delete]
    }
    
    
    private func deleteRowAtIndexPath(indexPath: NSIndexPath) {
        let realm = try! Realm()
        let objectToDelete = userList[indexPath.row]
        do {
            try realm.write() {
                realm.delete(objectToDelete)
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
        } catch {
            print("Could not delete site")
        }
    }
}

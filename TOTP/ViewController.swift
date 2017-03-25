//
//  ViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Base32
import CoreData
import RealmSwift
class ViewController: UIViewController, UITableViewDelegate  {
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var gitLabel: UILabel!
    weak var myTimer: Timer?
    let timer : DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var userList: Results<User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.editButtonPressed))
        readAndUpdateTable()
        tableView.delegate = self
        tableView.dataSource = self
        timer.scheduleRepeating(deadline: .now(), interval: .seconds(30))
        timer.setEventHandler {
            self.readAndUpdateTable()
        }
        timer.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func readAndUpdateTable() {
        userList = realm.objects(User.self)
        self.tableView.setEditing(false, animated: true)
        self.tableView.reloadData()
    }
    
    func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.editButtonPressed))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.editButtonPressed))
        }
    }
}


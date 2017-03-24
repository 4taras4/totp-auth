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
        self.tableView.reloadData()
    }
    
    func updateGitHub() {
        let name = "4taras4"
        let issuer = "GitHub"
        let secretString = "znftv4acphaepkcr"
        guard let secretData = MF_Base32Codec.data(fromBase32String: secretString),
            !secretData.isEmpty else {
                print("Invalid secret")
                return
        }
        
        guard let generator = Generator(
            factor: .timer(period: 30),
            secret: secretData,
            algorithm: .sha1,
            digits: 6) else {
                print("Invalid generator parameters")
                return
        }
        let token  = Token(name: name, issuer: issuer, generator: generator)
        let  passGit = token.currentPassword
        DispatchQueue.main.async {
            print(passGit!)
        }

    }
}


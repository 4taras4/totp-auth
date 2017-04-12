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
import WatchConnectivity
import Crashlytics

class ViewController: UIViewController, UITableViewDelegate  {
    let defaults = UserDefaults.standard

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var refreshView: UIView!
    var userList: Results<User>!
    weak var myTimer: Timer?
    let timer : DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdateTable()
        transferRealmFile()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEditing(false, animated: true)
        
        if 30  > TOTPApi.sharedInstance.currentTime() {
            timer.scheduleRepeating(deadline: .now(), interval: .seconds(2))
        } else {
            timer.scheduleRepeating(deadline: .now(), interval: .seconds(30))
        }
        
        timer.setEventHandler {
            self.readAndUpdateTable()
            self.transferRealmFile()
        }
        
        timer.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readAndUpdateTable()
        DispatchQueue.main.async {
            self.readAndUpdateTable()
        }
    }
    

    
    func readAndUpdateTable() {
        let realm = try! Realm()
        UIView.performWithoutAnimation {
            self.userList = realm.objects(User.self)
            self.tableView.reloadData()
        }
    }
}

extension ViewController:WCSessionDelegate {
    //MARK: - Watch functrions 
    func activateSession(){
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
            transferRealmFile()
        }
    }
    
    func transferRealmFile(){
        if let path = Realm.Configuration().fileURL {
            WCSession.default().transferFile(path, metadata: nil)
        }
    }

    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
}

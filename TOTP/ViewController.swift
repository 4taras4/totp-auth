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

class ViewController: UIViewController, UITableViewDelegate  {
    let defaults = UserDefaults.standard

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var gitLabel: UILabel!
    @IBOutlet weak var refreshView: UIView!
    var userList: Results<User>!
    weak var myTimer: Timer?
    let timer : DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
    var tokenTOTP: String?
    
    @IBAction func refreshAction(_ sender: Any) {
        readAndUpdateTable()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readAndUpdateTable()
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
        }
        timer.resume()
        activateSession()
        transferRealmFile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readAndUpdateTable()
        loadFirstViewStory()
        DispatchQueue.main.async {
            self.readAndUpdateTable()
        }
    }
    
    func loadFirstViewStory()  {
        if defaults.object(forKey: "firstLoad") == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FirstLogin")
            self.present(controller, animated: true, completion: nil)
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


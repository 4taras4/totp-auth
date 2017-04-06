//
//  InterfaceController.swift
//  2Pass Extension
//
//  Created by Taras Markevych on 4/6/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import WatchKit
import Foundation
import RealmSwift
import WatchConnectivity

class InterfaceController: WKInterfaceController,WCSessionDelegate {
    var dataList: Results<User>?
    @IBOutlet var tableWatch: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        tableWatch.setNumberOfRows((dataList?.count)!, withRowType: "Cell")
        for index in 0..<tableWatch.numberOfRows {
            if let controller = tableWatch.rowController(at: index) as? TableCellData {
                controller.data = dataList
            }
        }
        activateSession()
        reloadTableData()
    }
    
    func reloadTableData() {
        let realm = try! Realm()
        dataList = realm.objects(User.self)
        print(dataList)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func activateSession(){
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    @available(watchOS 2.2, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    // When the file was received
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
        //set the recieved file to default Realm file
        var config = Realm.Configuration()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let realmURL = documentsDirectory.appendingPathComponent("data.realm")
        if FileManager.default.fileExists(atPath: realmURL.path){
            try! FileManager.default.removeItem(at: realmURL)
        }
        try! FileManager.default.copyItem(at: file.fileURL, to: realmURL)
        config.fileURL = realmURL
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let newUser = User()
        newUser.name = "test"
        newUser.issuer = "tester"
        newUser.token = "2HPL NXP6 67Q2 NN3R"
        try! realm.write {
            realm.add(newUser, update: true)
        }
        // display the first of realm objects
        if let firstField = realm.objects(User.self).first{
            print(firstField)
        }
    }
}

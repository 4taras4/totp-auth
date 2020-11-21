//
//  ExtensionDelegate.swift
//  TwoPass Extension
//
//  Created by Taras Markevych on 20.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WatchKit
import WatchConnectivity
class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    private lazy var connectivityDelegate: ConnectivityDelegate = {
        return ConnectivityDelegate()
    }()
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        WCSession.default.delegate = connectivityDelegate
        WCSession.default.activate()
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        
    }

}

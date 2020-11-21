//
//  WatchSessionManager.swift
//  TOTP
//
//  Created by Taras Markevych on 22.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit
import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let shared = WatchSessionManager()
    
    public override init() {
        super.init()
        WCSession.default.delegate = self
        print("[WatchSessionManager] init delegate self")
        if WCSession.isSupported() {
            print("[WatchSessionManager] Session supported")
            WCSession.default.activate()
        }
    }
    
    func sendData(data: Data) {
        WCSession.default.sendMessageData(data, replyHandler: { data in
            print(String(data: data, encoding: .utf8))
        }, errorHandler: { error in
            print(error)
        })
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    // Called when WCSession reachability is changed.
    //
    func sessionReachabilityDidChange(_ session: WCSession) {
        if session.isReachable && session.isPaired {
            print("[WatchSessionManager] Send data")
        }
    }
    
    // Called when a piece of message data is received and the peer doesn't need a response.
    //
    func replyUserData() -> Data? {
        let encoder = JSONEncoder()
        let users = RealmManager.shared.fetchCodesList() ?? []
        do {
            return try encoder.encode(users)
        } catch let error {
            print(error)
            return nil
        }
    }
    // Called when a piece of message data is received and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        replyHandler(replyUserData() ?? Data())
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("[WatchSessionManager] \(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("[WatchSessionManager] \(#function): activationState = \(session.activationState.rawValue)")
    }
}

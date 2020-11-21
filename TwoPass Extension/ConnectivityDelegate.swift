//
//  ConnectivityDelegate.swift
//  TwoPass Extension
//
//  Created by Taras Markevych on 22.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WatchConnectivity

class ConnectivityDelegate: NSObject, WCSessionDelegate {
    weak var delegateUI:ContentUpdateDelegate?

    func sendData(data: Data) {
        WCSession.default.sendMessageData(data, replyHandler: { data in
            print("receive items bytes:", data.count)
            if data.count > 0 {
                UserDefaults.standard.set(data, forKey: Constants.settings.contentsJson)
                self.delegateUI?.updateUI()
            }
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
        if session.isReachable {
            print("[WatchSessionManager] Send data")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print("receive items bytes:", messageData.count)
        if messageData.count > 0 {
            UserDefaults.standard.set(messageData, forKey: Constants.settings.contentsJson)
            self.delegateUI?.updateUI()

        }
    }
    // Called when a piece of message data is received and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        self.session(session, didReceiveMessageData: messageData)
        replyHandler(Data())
    }
    
}

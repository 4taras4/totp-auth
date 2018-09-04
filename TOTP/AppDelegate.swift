//
//  AppDelegate.swift
//  TOTP
//  2HPL NXP6 67Q2 NN3R

//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import RealmSwift
import Fabric
import Crashlytics
import IceCream
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var syncEngine: SyncEngine?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self, Answers.self ])
        //Realm configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {}
        })
        syncEngine = SyncEngine(objects: [
            SyncObject<User>()])
        application.registerForRemoteNotifications()

        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let dict = userInfo as! [String: NSObject]
        let notification = CKNotification(fromRemoteNotificationDictionary: dict)
        
        if (notification.subscriptionID == IceCreamConstant.cloudKitSubscriptionID) {
            NotificationCenter.default.post(name: Notifications.cloudKitDataDidChangeRemotely.name, object: nil, userInfo: userInfo)
        }
        completionHandler(.newData)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if UserDefaults.standard.object(forKey: "touchID") as? String == "1" {
            if let imageView : UIView = UIApplication.shared.keyWindow?.subviews.last?.viewWithTag(101) {
                imageView.removeFromSuperview()
            }
            let imageView = UIView(frame: UIScreen.main.bounds)
            imageView.tag = 101
            let blurEffect = UIBlurEffect(style: .extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = imageView.frame
            imageView.addSubview(blurEffectView)
            UIView.animate(withDuration: 0.5, animations: {
                UIApplication.shared.keyWindow?.subviews.last?.addSubview(imageView)
            })
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let imageView : UIView = UIApplication.shared.keyWindow?.subviews.last?.viewWithTag(101) {
            imageView.removeFromSuperview()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Security")
            UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        }
    }
}


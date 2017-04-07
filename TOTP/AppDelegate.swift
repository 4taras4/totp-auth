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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self, Answers.self ])
        //Realm configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {}
        })
//        var config = Realm.Configuration()
//        config.fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.totp.app")!.appendingPathComponent("default.realm")
//        Realm.Configuration.defaultConfiguration = config
        return true
    }
}


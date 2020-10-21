//
//  AppDelegate.swift
//  TOTP
//  2HPL NXP6 67Q2 NN3R

//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import RealmSwift
import Swinject
import GoogleMobileAds
import Firebase

let assembler = Assembler()
let container = assembler.resolver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var autoBlur = AutoBlurScreen()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        assembler.apply(assemblies: [MainListAssemblyContainer(), SettingsAssemblyContainer(), AddItemAssemblyContainer(), AddItemManualyAssemblyContainer()])
        window = UIWindow(frame: UIScreen.main.bounds)
       
        UIManager.shared.configure(with: window!)
        AppDelegate.autoBlur.isAutoBlur = UserDefaults.standard.bool(forKey: Constants.settings.blur)
        AppDelegate.autoBlur.blurStyle = .dark
        //Realm configuration
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {}
        })
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        RealmManager.shared.widgetDataMigration()
        FirebaseApp.configure()
        return true
    }
}


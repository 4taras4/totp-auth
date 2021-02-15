//
//  SettingsSettingsRouter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

final class SettingsRouter: SettingsRouterInput {

	weak var transitionHandler: UIViewController!
    
    func showFolderSettings() {
        let settingsViewController = FolderSettingsViewController.instantiate(useSwinject: true)
        transitionHandler.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

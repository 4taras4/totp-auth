//
//  MainListMainListRouter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

final class MainListRouter: MainListRouterInput {

	weak var transitionHandler: UIViewController!
    
    func openSettings() {
        let settingsViewController = SettingsViewController.instantiate(useSwinject: true)
        transitionHandler.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func addItem() {
        let newItemViewController = AddItemViewController.instantiate(useSwinject: true)
        transitionHandler.navigationController?.pushViewController(newItemViewController, animated: true)
    }
    
    func openFolder(item: Folder) {
        let newItemViewController = FolderDetailsViewController.instantiate(with: item)
        transitionHandler.navigationController?.pushViewController(newItemViewController, animated: true)
    }
}

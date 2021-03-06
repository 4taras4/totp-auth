//
//  FolderSettingsFolderSettingsRouter.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import UIKit

final class FolderSettingsRouter: FolderSettingsRouterInput {
	weak var transitionHandler: UITableViewController!
    
    func openSettings(for folder: Folder) {
        let vc = AddFolderItemsViewController.instantiate(with: folder)
        transitionHandler.navigationController?.pushViewController(vc, animated: true)
    }

}

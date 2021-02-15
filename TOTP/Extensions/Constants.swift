//
//  Constants.swift
//  TOTP
//
//  Created by Taras Markevych on 11.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

struct Constants {
    enum settings {
        static let blur = "blur"
        static let biometric = "biometric"
        static let contentsJson = "contents.json"
        static let appGroup = "group.totp.app"
    }
    
    enum adds {
        static let bannerId = "ca-app-pub-3529414992545097/2720851359"
    }
    
    enum iCloud {
        static let appId = "iCloud.com.tarik.Auth"
        static let documents = "Documents"
        static let realm = "default.realm"
    }
    
    enum text {
        static let cameraAlertTitle = "Camera access denied"
        static let cameraAlertDescription = "Go to Settings and allow camera permission to scan QR"
        static let settingsAlertButton = "Settings"
        static let cancelAlertButton = "Cancel"
        static let createAlertButton = "Create"
        static let removeAlertButton = "Remove"
        static let settingsErrorAlertTitle = "Error ❌"
        static let settingsSuccessAlertTitle = "Success 🎉"
        static let settingsSuccessRestoredDataAlertDescription = "Data restored from backup ✅"
        static let settingsSuccessBackupDataCreatedAlertDescription = "Backup created ✅"
        static let settingsMailUnavailableAlertDescription = "Mail client unavailable. Please login to native Mail client to send message"
        static let cantAddTokenAlertDescription = "Can't add token"
        static let favouritesTableTitle = "Favourites"
        static let fullListTableTitle = "Full List"
        static let removeBackupAlertTitle = "Remove selected account"
        static let removeBackupAlertDescription = "if you remove account it's will be deleted permamently"
        static let biometricDescription = "Log in with Biometrics"
        static let addItemsToFolderHeader1 = "Select account to add on folder:"
        static let addItemsToFolderHeader2 = ".\nUnselect if you want to remove item from folder"
        static let addNewItemText = "Add new item"
        static let folderNamePlaceholder = "Folder name"
        static let folderNameTitle = "Enter Folder name"
        static let folderHeaderTitle = "Folders"
        static let folderNameDescription = "After creating Folder go to folder settings and add items to folder"

    }
}

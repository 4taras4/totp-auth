//
//  MainListMainListViewOutput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit
import Foundation

protocol MainListViewOutput: class, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
	/// - author: Tarik
	func viewIsReady()
    
    func refreshData()
    
    func settingsButtonPressed()
    
    func addItemButtonPressed()
    
    func favItemButtonPressed()
    
    func reloadFolders()
}

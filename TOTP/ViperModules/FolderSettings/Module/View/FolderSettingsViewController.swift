//
//  FolderSettingsFolderSettingsViewController.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class FolderSettingsViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: FolderSettingsViewOutput!
    var bannerView: GADBannerView!

    @IBAction func editAction(_ sender: Any) {
        output.editButtonPressed()
    }
	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        tableView.delegate = output
        tableView.dataSource = output
		output.viewIsReady()
        setupAddsViewElements()
    }
    
    
    func setupAddsViewElements() {
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = Constants.adds.bannerId
        bannerView.rootViewController = self
        bannerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView.load(GADRequest())
    }

}

// MARK: -
// MARK: FolderSettingsViewInput
extension FolderSettingsViewController: FolderSettingsViewInput {
    func showError(error: String) {
        UIManager.shared.showAlert(title: nil, message: error)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func changeIsEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    

	func setupInitialState() {

	}

}


extension FolderSettingsViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "FolderSettingsViewController"
    }
}

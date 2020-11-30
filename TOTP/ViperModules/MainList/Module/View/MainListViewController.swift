//
//  MainListMainListViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class MainListViewController: UIViewController {

	// MARK: -
	// MARK: Properties
	var output: MainListViewOutput!
   
    @IBAction func addAction(_ sender: Any) {
        output.addItemButtonPressed()
    }
    
    @IBAction func settingsAction(_ sender: Any) {
        output.settingsButtonPressed()
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        output.favItemButtonPressed()
    }
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: -
	// MARK: Life cycle
    
    var bannerView: GADBannerView!
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        setupViewElements()
	}
    
    func setupViewElements() {
        tableView.delegate = output
        tableView.dataSource = output
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = Constants.adds.bannerId
        bannerView.rootViewController = self
        bannerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.refreshData()
        bannerView.load(GADRequest())
    }
}

// MARK: -
// MARK: MainListViewInput
extension MainListViewController: MainListViewInput {
    func reloadTable() {
        tableView.reloadData()
    }
    
	func setupInitialState() {

	}

    func changeIsEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}

extension MainListViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "MainListViewController"
    }
}

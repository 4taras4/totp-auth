//
//  FolderDetailsFolderDetailsViewController.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class FolderDetailsViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: FolderDetailsViewOutput!
    var bannerView: GADBannerView!

	// MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
		output.viewIsReady()
        tableView.delegate = output
        tableView.dataSource = output
        setupAddsViewElements()
	}
    
    
    func setupAddsViewElements() {
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = Constants.adds.bannerId
        bannerView.rootViewController = self
        bannerView.delegate = self
    }

    static func instantiate(with folder: Folder) -> FolderDetailsViewController {
        let viewController = FolderDetailsViewController.instantiate(useSwinject: true)
        let output = container.resolve(FolderDetailsPresenter.self, arguments: viewController, folder)
        viewController.output = output
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.refreshData()
        bannerView.load(GADRequest())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        output.invalidateTimer()
    }
}

// MARK: -
// MARK: FolderDetailsViewInput
extension FolderDetailsViewController: FolderDetailsViewInput {
    func setTitle(string: String) {
        title = string
    }
    
  
    func reloadTable() {
        tableView.reloadData()
    }
    

	func setupInitialState() {

	}

}

extension FolderDetailsViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "FolderDetailsViewController"
    }
}

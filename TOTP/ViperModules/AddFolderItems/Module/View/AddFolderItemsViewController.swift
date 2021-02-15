//
//  AddFolderItemsAddFolderItemsViewController.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class AddFolderItemsViewController: UITableViewController {

	// MARK: -
	// MARK: Properties
	var output: AddFolderItemsViewOutput!
    var bannerView: GADBannerView!

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

    static func instantiate(with folder: Folder) -> AddFolderItemsViewController {
        let viewController = AddFolderItemsViewController.instantiate(useSwinject: true)
        let output = container.resolve(AddFolderItemsPresenter.self, arguments: viewController, folder)
        viewController.output = output
        return viewController
    }
}

// MARK: -
// MARK: AddFolderItemsViewInput
extension AddFolderItemsViewController: AddFolderItemsViewInput {
    func showError(error: Error) {
        UIManager.shared.showAlert(title: "", message: error.localizedDescription)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }

	func setupInitialState() {

	}
    

}


extension AddFolderItemsViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "AddFolderItemsViewController"
    }
}

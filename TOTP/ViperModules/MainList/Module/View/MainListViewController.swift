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
    @IBOutlet weak var foldersCollectionView: UICollectionView!

    // MARK: -
	// MARK: Life cycle
    
    var bannerView: GADBannerView!
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        setupViewElements()
        setupCollectionView()
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
    
    func setupCollectionView() {
        let folderCell = UINib(nibName: "FolderItemCollectionViewCell", bundle: nil)
        foldersCollectionView.register(folderCell, forCellWithReuseIdentifier: "FolderItemCollectionViewCell")
        foldersCollectionView.delegate = output
        foldersCollectionView.dataSource = output
        let collectionFlow = UICollectionViewFlowLayout()
            collectionFlow.scrollDirection = .horizontal
            collectionFlow.estimatedItemSize = CGSize(width: 10, height: 10)
            collectionFlow.sectionInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        foldersCollectionView.collectionViewLayout = collectionFlow
        foldersCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.refreshData()
        output.reloadFolders()
        bannerView.load(GADRequest())
    }
}

// MARK: -
// MARK: MainListViewInput
extension MainListViewController: MainListViewInput {
    func changeCollectionView(isHidden: Bool) {
        foldersCollectionView.isHidden = isHidden
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
	func setupInitialState() {

	}
    
    func reloadFoldersCollectionView() {
        foldersCollectionView.reloadData()
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

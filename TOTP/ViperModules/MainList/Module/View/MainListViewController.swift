//
//  MainListMainListViewController.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: -
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		output.viewIsReady()
        tableView.delegate = output
        tableView.dataSource = output
	}
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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

}

extension MainListViewController: NibIdentifiable {
    static var nibNameIdentifier: String {
        return "Main"
    }
    static var controllerIdentifier: String {
        return "MainListViewController"
    }
}
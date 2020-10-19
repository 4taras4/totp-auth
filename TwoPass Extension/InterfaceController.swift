//
//  InterfaceController.swift
//  TwoPass Extension
//
//  Created by Taras Markevych on 20.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WatchKit
import Foundation
import RealmSwift

class InterfaceController: WKInterfaceController {
    @IBOutlet var tableView: WKInterfaceTable!

    var refreshTimer: Timer?
    var interval = 30.0
    var updated: Int = 0
    var codes = [Code]() {
        didSet {
            updateTimerIfNeeded()
            setTable()
        }
    }
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        startRefreshData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    func startRefreshData() {
        updated = 0
        let calendar = Calendar.current
        let time = calendar.dateComponents([.second], from: Date()).second!
        if time > 30 {
            interval = Double(60 - time)
        } else {
            interval = Double(30 - time)
        }
        print("init:", interval)
        refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    private func setTable() {
        tableView.setNumberOfRows(codes.count, withRowType: "CodeTableViewRow")
        for index in 0..<tableView.numberOfRows {
            if let cell = tableView.rowController(at: index) as? CodeTableViewRow {
                cell.setup(cell: codes[index])
            }
        }
    }

    @objc func refreshData() {
        codes = WatchDataManager.shared.getOptList()
    }
    
    func updateTimerIfNeeded() {
        updated += 1
        if interval != 30.0, updated == 2 {
            print("set new time")
            self.interval = 30
            refreshTimer?.invalidate()
            refreshTimer = nil
            refreshTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
        }
    }
}

//
//  TOTPTests.swift
//  TOTPTests
//
//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//
import Base32
import Foundation
import UIKit
import XCTest
@testable import TOTP

class TOTPTests: XCTestCase {
    
    func testKeychainAdd() {
        let name = "4taras4"
        let issuer = "GitHub"
        let secretString = "znftv4acphaepkcr"

        let pass = TOTPApi.sharedInstance.refreshToken(name: name, issuer: issuer, secretData: secretString)
        print(pass)
    }
    
    func testSaveDataToDB() {
        RealmData.saveToDB(name: "Google", issuer: "google", token:"znftv4acphaepkcr" )
    }
    
    func testUICirleView() {
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width - 10, height: 10))
        let circleView = Circle(frame: CGRect(x:0, y:0, width:20, height:20))
        myView.addSubview(circleView)
        circleView.animateCircle(duration:1)
    }
    
    func testHUD() {
         SwiftNotice.showNoticeWithText(NoticeType.success, text: "test", autoClear: true, autoClearTime: 1)
    }
}

//
//  TOTPTests.swift
//  TOTPTests
//
//  Created by Taras Markevych on 3/22/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//
import Base32

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
    
}

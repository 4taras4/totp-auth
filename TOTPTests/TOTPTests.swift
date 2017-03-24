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

        TOTPApi.sharedInstance.add(name: name, issuer: issuer, token: secretString)
    }
    
    func testKeychainRead() {
        KeyhcainApi.sharedInstance.readTokens()
    }
    
    
    func testSaveDataToDB() {
        guard let secretData = MF_Base32Codec.data(fromBase32String: "znftv4acphaepkcr"),!secretData.isEmpty else {
            print("Invalid secret")
            return
        }
        RealmData.saveToDB(name: "Google", issuer: "google", token:secretData )
    }
    
}

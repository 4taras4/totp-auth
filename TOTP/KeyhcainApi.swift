//
//  KeyhcainApi.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class KeyhcainApi: NSObject {
    public static let sharedInstance = KeyhcainApi()
    static let keychain = Keychain.sharedInstance

    func saveToken(token: Token) -> Void {
        do {
            let persistentToken = try KeyhcainApi.keychain.add(token)
            print("Saved to keychain with identifier: \(persistentToken.identifier)")
        } catch {
            print("Keychain error: \(error)")
        }
    }
    
    func readTokens()  -> Void {
        do {
            let persistentTokens = try KeyhcainApi.keychain.allPersistentTokens()
            print("All tokens: \(persistentTokens.map({ $0.identifier }))")
        } catch {
            print("Keychain error: \(error)")
        }
    }
 }

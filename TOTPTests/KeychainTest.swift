//
//  KeychainTest.swift
//  TOTP
//
//  Created by Taras Markevych on 26.03.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import XCTest
import Base32
@testable import TOTP

let testToken = Token(
    name: "Name",
    issuer: "Issuer",
    generator: Generator(
        factor: .timer(period: 45),
        secret: MF_Base32Codec.data(fromBase32String: "AAAQEAYEAUDAOCAJBIFQYDIOB4"),
        algorithm: .sha256,
        digits: 8
        )!
)

class KeychainTests: XCTestCase {
    let keychain = Keychain.sharedInstance
    
    func testPersistentTokenWithIdentifier() {
        // Create a token
        let token = testToken
        
        // Save the token
        let savedToken: PersistentToken
        do {
            savedToken = try keychain.add(token)
        } catch {
            XCTFail("addToken(_:) failed with error: \(error)")
            return
        }
        
        // Restore the token
        do {
            let fetchedToken = try keychain.persistentToken(withIdentifier: savedToken.identifier)
            XCTAssertEqual(fetchedToken, savedToken, "Token should have been saved to keychain")
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
        
        // Modify the token
        let modifiedToken = Token(
            name: "New Name",
            issuer: "New Issuer",
            generator: token.generator.successor()
        )
        do {
            let updatedToken = try keychain.update(savedToken, with: modifiedToken)
            XCTAssertEqual(updatedToken.identifier, savedToken.identifier)
            XCTAssertEqual(updatedToken.token, modifiedToken)
        } catch {
            XCTFail("updatePersistentToken(_:withToken:) failed with error: \(error)")
        }
        
        // Fetch the token again
        do {
            let fetchedToken = try keychain.persistentToken(withIdentifier: savedToken.identifier)
            XCTAssertEqual(fetchedToken?.token, modifiedToken)
            XCTAssertEqual(fetchedToken?.identifier, savedToken.identifier)
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
        
        // Remove the token
        do {
            try keychain.delete(savedToken)
        } catch {
            XCTFail("deletePersistentToken(_:) failed with error: \(error)")
        }
        
        // Attempt to restore the deleted token
        do {
            let fetchedToken = try keychain.persistentToken(withIdentifier: savedToken.identifier)
            XCTAssertNil(fetchedToken, "Token should have been removed from keychain")
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
    }
    
    func testDuplicateTokens() {
        let token1 = testToken, token2 = testToken
        
        // Add both tokens to the keychain
        let savedItem1: PersistentToken
        let savedItem2: PersistentToken
        do {
            savedItem1 = try keychain.add(token1)
            savedItem2 = try keychain.add(token2)
            XCTAssertEqual(savedItem1.token, token1)
            XCTAssertEqual(savedItem2.token, token2)
        } catch {
            XCTFail("addToken(_:) failed with error: \(error)")
            return
        }
        
        // Fetch both tokens from the keychain
        do {
            let fetchedItem1 = try keychain.persistentToken(withIdentifier: savedItem1.identifier)
            let fetchedItem2 = try keychain.persistentToken(withIdentifier: savedItem2.identifier)
            XCTAssertEqual(fetchedItem1, savedItem1, "Saved token not found in keychain")
            XCTAssertEqual(fetchedItem2, savedItem2, "Saved token not found in keychain")
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
        
        // Remove the first token from the keychain
        do {
            try keychain.delete(savedItem1)
        } catch {
            XCTFail("deletePersistentToken(_:) failed with error: \(error)")
        }
        
        do {
            let checkItem1 = try keychain.persistentToken(withIdentifier: savedItem1.identifier)
            let checkItem2 = try keychain.persistentToken(withIdentifier: savedItem2.identifier)
            XCTAssertNil(checkItem1, "Token should not be in keychain: \(token1)")
            XCTAssertNotNil(checkItem2, "Token should be in keychain: \(token2)")
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
        
        // Remove the second token from the keychain
        do {
            try keychain.delete(savedItem2)
        } catch {
            XCTFail("deletePersistentToken(_:) failed with error: \(error)")
        }
        
        do {
            let recheckItem1 = try keychain.persistentToken(withIdentifier: savedItem1.identifier)
            let recheckItem2 = try keychain.persistentToken(withIdentifier: savedItem2.identifier)
            XCTAssertNil(recheckItem1, "Token should not be in keychain: \(token1)")
            XCTAssertNil(recheckItem2, "Token should not be in keychain: \(token2)")
        } catch {
            XCTFail("persistentTokenWithIdentifier(_:) failed with error: \(error)")
        }
        
        // Try to remove both tokens from the keychain again
        do {
            try keychain.delete(savedItem1)
            // The deletion should throw and this line should never be reached.
            XCTFail("Removing again should fail: \(token1)")
        } catch {
            // An error thrown is the expected outcome
        }
        do {
            try keychain.delete(savedItem2)
            // The deletion should throw and this line should never be reached.
            XCTFail("Removing again should fail: \(token2)")
        } catch {
            // An error thrown is the expected outcome
        }
    }
    
    func testAllPersistentTokens() {
        let token1 = testToken, token2 = testToken, token3 = testToken
        
        do {
            let noTokens = try keychain.allPersistentTokens()
            XCTAssert(noTokens.isEmpty, "Expected no tokens in keychain: \(noTokens)")
        } catch {
            XCTFail("allPersistentTokens() failed with error: \(error)")
        }
        
        let persistentToken1: PersistentToken
        let persistentToken2: PersistentToken
        let persistentToken3: PersistentToken
        do {
            persistentToken1 = try keychain.add(token1)
            persistentToken2 = try keychain.add(token2)
            persistentToken3 = try keychain.add(token3)
        } catch {
            XCTFail("addToken(_:) failed with error: \(error)")
            return
        }
        
        do {
            let allTokens = try keychain.allPersistentTokens()
            XCTAssertEqual(allTokens, [persistentToken1, persistentToken2, persistentToken3],
                           "Tokens not correctly recovered from keychain")
        } catch {
            XCTFail("allPersistentTokens() failed with error: \(error)")
        }
        
        do {
            try keychain.delete(persistentToken1)
            try keychain.delete(persistentToken2)
            try keychain.delete(persistentToken3)
        } catch {
            XCTFail("deletePersistentToken(_:) failed with error: \(error)")
        }
        
        do {
            let noTokens = try keychain.allPersistentTokens()
            XCTAssert(noTokens.isEmpty, "Expected no tokens in keychain: \(noTokens)")
        } catch {
            XCTFail("allPersistentTokens() failed with error: \(error)")
        }
    }
}

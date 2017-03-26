//
//  CryptTest.swift
//  TOTP
//
//  Created by Taras Markevych on 26.03.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import XCTest
@testable import TOTP

class CryptTest: XCTestCase {
        func testFactorEquality() {
            let c0 = Generator.Factor.counter(30)
            let c1 = Generator.Factor.counter(60)
            let t0 = Generator.Factor.timer(period: 30)
            let t1 = Generator.Factor.timer(period: 60)
            
            XCTAssertEqual(c0, c0)
            XCTAssertEqual(c1, c1)
            XCTAssertNotEqual(c0, c1)
            XCTAssertNotEqual(c1, c0)
            
            XCTAssertEqual(t0, t0)
            XCTAssertEqual(t1, t1)
            XCTAssertNotEqual(t0, t1)
            XCTAssertNotEqual(t1, t0)
            
            XCTAssertNotEqual(c0, t0)
            XCTAssertNotEqual(c0, t1)
            XCTAssertNotEqual(c1, t0)
            XCTAssertNotEqual(c1, t1)
            
            XCTAssertNotEqual(t0, c0)
            XCTAssertNotEqual(t0, c1)
            XCTAssertNotEqual(t1, c0)
            XCTAssertNotEqual(t1, c1)
        }
        
        func testGeneratorEquality() {
            let g = Generator(factor: .counter(0), secret: Data(), algorithm: .sha1, digits: 6)
            let badData = "0".data(using: String.Encoding.utf8)!
            
            XCTAssert(g == Generator(factor: .counter(0), secret: Data(), algorithm: .sha1, digits: 6))
            XCTAssert(g != Generator(factor: .counter(1), secret: Data(), algorithm: .sha1, digits: 6))
            XCTAssert(g != Generator(factor: .counter(0), secret: badData, algorithm: .sha1, digits: 6))
            XCTAssert(g != Generator(factor: .counter(0), secret: Data(), algorithm: .sha256, digits: 6))
            XCTAssert(g != Generator(factor: .counter(0), secret: Data(), algorithm: .sha1, digits: 8))
        }
        
        func testTokenEquality() {
            guard let generator = Generator(factor: .counter(0), secret: Data(), algorithm: .sha1, digits: 6),
                let other_generator = Generator(factor: .counter(1), secret: Data(), algorithm: .sha512, digits: 8) else {
                    XCTFail()
                    return
            }
            
            let t = Token(name: "Name", issuer: "Issuer", generator: generator)
            
            XCTAssertEqual(t, Token(name: "Name", issuer: "Issuer", generator: generator))
            XCTAssertNotEqual(t, Token(name: "", issuer: "Issuer", generator: generator))
            XCTAssertNotEqual(t, Token(name: "Name", issuer: "", generator: generator))
            XCTAssertNotEqual(t, Token(name: "Name", issuer: "Issuer", generator: other_generator))
        }
}

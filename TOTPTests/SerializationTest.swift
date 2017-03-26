//
//  SerializationTest.swift
//  TOTP
//
//  Created by Taras Markevych on 26.03.17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import XCTest
import Base32
@testable import TOTP


class SerializationTest: XCTestCase {
    let kOTPScheme = "otpauth"
    let kOTPTokenTypeCounterHost = "hotp"
    let kOTPTokenTypeTimerHost   = "totp"
    
    let factors: [Generator.Factor] = [
        .counter(0),
        .counter(1),
        .counter(UInt64.max),
        .timer(period: 1),
        .timer(period: 30),
        .timer(period: 300),
        ]
    let names = ["", "Login", "user@google.com", "tarik", ":/?#[]@!$&'()*+,;=%\""]
    let issuers = ["", "Big Cörpøráçìôn", ":/?#[]@!$&'()*+,;=%\""]
    let secretStrings = [
        "12345678901234567890",
        "12345678901234567890123456789012",
        "1234567890123456789012345678901234567890123456789012345678901234"
        ]
    let algorithms: [Generator.Algorithm] = [.sha1, .sha256, .sha512]
    let digits = [6, 7, 8]
    
    func testSerialization() {
        for factor in factors {
            for name in names {
                for issuer in issuers {
                    for secretString in secretStrings {
                        for algorithm in algorithms {
                            for digitNumber in digits {
                                // Create the token
                                guard let generator = Generator(
                                    factor: factor,
                                    secret: secretString.data(using: String.Encoding.ascii)!,
                                    algorithm: algorithm,
                                    digits: digitNumber
                                    ) else {
                                        XCTFail()
                                        continue
                                }
                                
                                let token = Token(
                                    name: name,
                                    issuer: issuer,
                                    generator: generator
                                )
                                
                                // Serialize
                                guard let url = try? token.toURL() else {
                                    XCTFail("Failed to convert Token to URL")
                                    continue
                                }
                                
                                // Test scheme
                                XCTAssertEqual(url.scheme, kOTPScheme, "The url scheme should be \"\(kOTPScheme)\"")
                                // Test Factor
                                var expectedHost: String
                                switch factor {
                                case .counter:
                                    expectedHost = kOTPTokenTypeCounterHost
                                case .timer:
                                    expectedHost = kOTPTokenTypeTimerHost
                                }
                                XCTAssertEqual(url.host!, expectedHost, "The url host should be \"\(expectedHost)\"")
                                // Test name
                                let path = url.path
                                XCTAssertEqual(path.substring(from: path.index(after: path.startIndex)), name,
                                               "The url path should be \"\(name)\"")
                                
                                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                                let items = urlComponents?.queryItems
                                let expectedItemCount = 4
                                XCTAssertEqual(items?.count, expectedItemCount,
                                               "There shouldn't be any unexpected query arguments: \(url)")
                                
                                var queryArguments = Dictionary<String, String>()
                                for item in items ?? [] {
                                    queryArguments[item.name] = item.value
                                }
                                XCTAssertEqual(queryArguments.count, expectedItemCount,
                                               "There shouldn't be any unexpected query arguments: \(url)")
                                
                                // Test algorithm
                                let algorithmString: String = {
                                    switch $0 {
                                    case .sha1:
                                        return "SHA1"
                                    case .sha256:
                                        return "SHA256"
                                    case .sha512:
                                        return "SHA512"
                                    }}(algorithm)
                                XCTAssertEqual(queryArguments["algorithm"]!, algorithmString,
                                               "The algorithm value should be \"\(algorithmString)\"")
                                // Test digits
                                XCTAssertEqual(queryArguments["digits"]!, String(digitNumber),
                                               "The digits value should be \"\(digitNumber)\"")
                                // Test secret
                                XCTAssertNil(queryArguments["secret"],
                                             "The url query string should not contain the secret")
                                
                                // Test period
                                switch factor {
                                case .timer(let period):
                                    XCTAssertEqual(queryArguments["period"]!, String(Int(period)),
                                                   "The period value should be \"\(period)\"")
                                default:
                                    XCTAssertNil(queryArguments["period"],
                                                 "The url query string should not contain the period")
                                }
                                // Test counter
                                switch factor {
                                case .counter(let counter):
                                    XCTAssertEqual(queryArguments["counter"]!, String(counter),
                                                   "The counter value should be \"\(counter)\"")
                                default:
                                    XCTAssertNil(queryArguments["counter"],
                                                 "The url query string should not contain the counter")
                                }
                                
                                // Test issuer
                                XCTAssertEqual(queryArguments["issuer"]!, issuer,
                                               "The issuer value should be \"\(issuer)\"")
                                
                                // Check url again
                                guard let checkURL = try? token.toURL() else {
                                    XCTFail("Failed to convert Token to URL")
                                    continue
                                }
                                XCTAssertEqual(url, checkURL, "Repeated calls to url() should return the same result!")
                            }
                        }
                    }
                }
            }
        }
    }
}

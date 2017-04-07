//
//  TOTPApi.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Base32

public class TOTPApi {
    
    static let sharedInstance = TOTPApi()
   
    let timer:TimeInterval = 30
    
       func refreshToken(name:String?, issuer:String?, secretData: String?) -> String {
        guard let secretData = MF_Base32Codec.data(fromBase32String: secretData),!secretData.isEmpty else {
            return "Invalid data"
        }
        
        guard let generator = Generator(factor: .timer(period: timer),secret: secretData,algorithm: .sha1,digits: 6) else {
            return "Invalid generator parameters"
        }
        
        let tokenTOTP  = Token(name: name!, issuer: issuer!, generator: generator)
        print(tokenTOTP.currentPassword!)
        let password = tokenTOTP.currentPassword!
        return password
    }
    
    func currentTime() -> Int {
            let date = Date()
            let calendar = Calendar.current
            let second = calendar.component(.second, from: date)
            let expiredTime = second % 30
            let validTime = 30 - expiredTime
        return validTime
    }

    
}

extension String {
    func appendingPathComponent(_ string: String) -> String {
        return URL(fileURLWithPath: self).appendingPathComponent(string).path
    }
}

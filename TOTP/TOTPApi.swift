//
//  TOTPApi.swift
//  TOTP
//
//  Created by Taras Markevych on 3/24/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Base32

class TOTPApi {
    
    static let sharedInstance = TOTPApi()
   
    let timer:TimeInterval = 30
    
       func refreshToken(name:String?, issuer:String?, secretData: String?) -> String {
        guard let secretData = MF_Base32Codec.data(fromBase32String: secretData),!secretData.isEmpty else {
            print("Invalid secret")
            return "Invalid data"
        }
        
        guard let generator = Generator(factor: .timer(period: timer),secret: secretData,algorithm: .sha1,digits: 6) else {
            print("Invalid generator parameters")
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
            print(expiredTime)
            let validTime = 30 - expiredTime
            print(validTime)
            return validTime
    }

    
}

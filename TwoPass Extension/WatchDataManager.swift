//
//  WatchDataManager.swift
//  TwoPass Extension
//
//  Created by Taras Markevych on 20.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import WatchKit
import OneTimePassword
import Base32
import WatchConnectivity
protocol ContentUpdateDelegate: class {
    func updateUI()
}

class WatchDataManager {
   
    static let shared = WatchDataManager()
    
    func getOptList() -> [Code] {
        var codesArray = [Code]()
        let users = readContents()
        for u in users {
            if let c = convertUser(user: u) {
                codesArray.append(c)
            }
        }
        return codesArray
    }
    
    private func readContents() -> [User] {
        var contents: [User] = []
        let archiveURL = FileManager.sharedContainerURL().appendingPathComponent(Constants.settings.contentsJson)
        let decoder = JSONDecoder()
        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                contents = try decoder.decode([User].self, from: codeData)
            } catch {
                print("Error: Can't decode contents")
            }
        }
        if contents.isEmpty {
            if let localStorage = UserDefaults.standard.object(forKey: Constants.settings.contentsJson) as? Data {
                print("Get items from local storage")
                do {
                    contents = try decoder.decode([User].self, from: localStorage)
                } catch {
                    print("Error: Can't decode contents")
                }
            }
        }
        return contents
    }

    private func convertUser(user: User) -> Code? {
        guard let secretData = MF_Base32Codec.data(fromBase32String: user.token),
            !secretData.isEmpty else {
                print("Invalid secret")
                return nil
        }

        guard let generator = Generator(
            factor: .timer(period: 30),
            secret: secretData,
            algorithm: .sha1,
            digits: 6) else {
                print("Invalid generator parameters")
                return nil
        }
        
        let token = Token(name: user.name ?? "", issuer: user.issuer ?? "", generator: generator)
        guard let currentCode = token.currentPassword else {
            print("Invalid generator parameters")
            return nil
        }
        return Code(name: user.name, issuer: user.issuer, code: currentCode)
    }
}

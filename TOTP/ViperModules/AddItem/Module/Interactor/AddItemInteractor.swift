//
//  AddItemAddItemInteractor.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import OneTimePassword

final class AddItemInteractor: AddItemInteractorInput {

	weak var output: AddItemInteractorOutput!
    
    func setToken(string: String) {
        if let url = URL(string: string), let tokenData = Token(url: url) {
            guard let secretKey = url.absoluteString.components(separatedBy: "secret=").last?.components(separatedBy: "&issuer=").first else {
                self.output.addTokenFails()
                return
            }
            print(secretKey)
            RealmManager.shared.saveNewUser(name: tokenData.name, issuer: tokenData.issuer, token: secretKey, completionHandler: { isSuccess in
                if isSuccess {
                    self.output.tokenAdded()
                } else {
                    self.output.addTokenFails()
                }
            })
        } else {
            output.addTokenFails()
        }
    }
}

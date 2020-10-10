//
//  AddItemManualyAddItemManualyInteractor.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import OneTimePassword
final class AddItemManualyInteractor: AddItemManualyInteractorInput {
    
	weak var output: AddItemManualyInteractorOutput!

    func setToken(string: String) {
        if let url = URL(string: string), let tokenData = Token(url: url) {
            RealmManager.shared.saveNewUser(name: tokenData.name, issuer: tokenData.issuer, token: tokenData.generator.secret.base64EncodedString(), completionHandler: { isSuccess in
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

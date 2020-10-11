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
    private var secret: String?
    private var name: String?
    private var issuer: String?
    
    func viewWantsToUpdate(secret: String) {
        self.secret = secret
    }
    
    func viewWantsToUpdate(name: String) {
        self.name = name
    }
    
    func viewWantsToUpdate(issuer: String) {
        self.issuer = issuer
    }
    
    func save() {
        guard let secret = secret, let name = name else {
            output.addTokenFails()
            return
        }
        RealmManager.shared.saveNewUser(name: name, issuer: self.issuer, token: secret, completionHandler: { isSuccess in
            if isSuccess {
                self.output.tokenAdded()
            } else {
                self.output.addTokenFails()
            }
        })
    }
}

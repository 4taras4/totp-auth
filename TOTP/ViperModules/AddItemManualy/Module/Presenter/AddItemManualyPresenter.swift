//
//  AddItemManualyAddItemManualyPresenter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

final class AddItemManualyPresenter: AddItemManualyViewOutput {
    // MARK: -
    // MARK: Properties

    weak var view: AddItemManualyViewInput!
    var interactor: AddItemManualyInteractorInput!
    var router: AddItemManualyRouterInput!

    // MARK: -
    // MARK: AddItemManualyViewOutput
    func viewIsReady() {

    }

    func save() {
        interactor.save()
    }
    
    func viewWantsToUpdate(secret: String) {
        interactor.viewWantsToUpdate(secret: secret)
    }
    
    func viewWantsToUpdate(name: String) {
        interactor.viewWantsToUpdate(name: name)
    }
    
    func viewWantsToUpdate(issuer: String) {
        interactor.viewWantsToUpdate(issuer: issuer)
    }
}

// MARK: -
// MARK: AddItemManualyInteractorOutput
extension AddItemManualyPresenter: AddItemManualyInteractorOutput {
    func addTokenFails() {
        view.errorValidation()
    }
    
    func tokenAdded() {
        router.popToRoot()
    }
}

// MARK: -
// MARK: AddItemManualyModuleInput
extension AddItemManualyPresenter: AddItemManualyModuleInput {

}

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

}

// MARK: -
// MARK: AddItemManualyInteractorOutput
extension AddItemManualyPresenter: AddItemManualyInteractorOutput {
    func addTokenFails() {
        
    }
    
    func tokenAdded() {
    }
    

}

// MARK: -
// MARK: AddItemManualyModuleInput
extension AddItemManualyPresenter: AddItemManualyModuleInput {

}

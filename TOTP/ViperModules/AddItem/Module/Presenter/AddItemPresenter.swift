//
//  AddItemAddItemPresenter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import StoreKit

final class AddItemPresenter: AddItemViewOutput {
    
    // MARK: -
    // MARK: Properties

    weak var view: AddItemViewInput!
    var interactor: AddItemInteractorInput!
    var router: AddItemRouterInput!

    // MARK: -
    // MARK: AddItemViewOutput
    func viewIsReady() {

    }

    func setTokenUrl(string: String) {
        interactor.setToken(string: string)
    }
    
    func setManualyPressed() {
        router.pushManualyViewController()
    }
}

// MARK: -
// MARK: AddItemInteractorOutput
extension AddItemPresenter: AddItemInteractorOutput {
    func addTokenFails() {
        view.failedSaveData()
    }
    
    func tokenAdded() {
        router.popToRoot()
        SKStoreReviewController.requestReview()
    }
    

}

// MARK: -
// MARK: AddItemModuleInput
extension AddItemPresenter: AddItemModuleInput {

}

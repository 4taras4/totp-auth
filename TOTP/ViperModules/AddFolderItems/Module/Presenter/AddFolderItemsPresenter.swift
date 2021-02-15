//
//  AddFolderItemsAddFolderItemsPresenter.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

final class AddFolderItemsPresenter: AddFolderItemsViewOutput {

    // MARK: -
    // MARK: Properties

    weak var view: AddFolderItemsViewInput!
    var interactor: AddFolderItemsInteractorInput!
    var router: AddFolderItemsRouterInput!

    // MARK: -
    // MARK: AddFolderItemsViewOutput
    func viewIsReady() {

    }

}

// MARK: -
// MARK: AddFolderItemsInteractorOutput
extension AddFolderItemsPresenter: AddFolderItemsInteractorOutput {

}

// MARK: -
// MARK: AddFolderItemsModuleInput
extension AddFolderItemsPresenter: AddFolderItemsModuleInput {

}

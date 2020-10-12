//
//  AddItemManualyAddItemManualyRouter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

final class AddItemManualyRouter: AddItemManualyRouterInput {

	weak var transitionHandler: UIViewController!

    func popToRoot() {
        transitionHandler.navigationController?.popToRootViewController(animated: true)
    }
}

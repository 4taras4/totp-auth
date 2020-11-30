//
//  AddItemAddItemRouter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit

final class AddItemRouter: AddItemRouterInput {

	weak var transitionHandler: UIViewController!
    
    func popToRoot() {
        transitionHandler.navigationController?.popToRootViewController(animated: true)
    }
    
    func pushManualyViewController() {
        let newItemManualyViewController = AddItemManualyViewController.instantiate(useSwinject: true)
        transitionHandler.navigationController?.pushViewController(newItemManualyViewController, animated: true)
    }
    
    func showSettingsAlert() {
        let alertController = UIAlertController (title: Constants.text.cameraAlertTitle, message: Constants.text.cameraAlertDescription, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: Constants.text.settingsAlertButton, style: .default) { (_) -> Void in
               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }
               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl)
               }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: Constants.text.cancelAlertButton, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        transitionHandler.present(alertController, animated: true, completion: nil)
    }
}

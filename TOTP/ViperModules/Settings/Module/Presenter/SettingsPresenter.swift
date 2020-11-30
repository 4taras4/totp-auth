//
//  SettingsSettingsPresenter.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import UIKit
import MessageUI

final class SettingsPresenter: NSObject, SettingsViewOutput {

    // MARK: -
    // MARK: Properties

    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!

    // MARK: -
    // MARK: SettingsViewOutput
    func viewIsReady() {
        view.setBlurSwitch(isEnabled: UserDefaults.standard.bool(forKey: Constants.settings.blur))
        view.setBiometricSwitch(isEnabled: UserDefaults.standard.bool(forKey: Constants.settings.biometric))
    }
    
    func blurSetting(isEnabled: Bool) {
        interactor.setBlur(isEnabled: isEnabled)
    }
    
    func biometricSetting(isEnabled: Bool) {
        interactor.setBiometric(isEnabled: isEnabled)
    }
    
    func askReview() {
        if let url = URL(string: "https://apps.apple.com/us/app/2pass-totp/id1219919851?action=write-review") {
            UIApplication.shared.open(url)
        }
    }
    
    func writeFeedback() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            view.mailUnavailable()
            return
        }

        let composeVC = MFMailComposeViewController()
        composeVC.modalPresentationStyle = .overFullScreen
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["4taras4@gmail.com"])
        composeVC.setSubject("[2Pass: TOTP]")
        composeVC.setMessageBody("", isHTML: false)
        UIApplication.topViewController()?.present(composeVC, animated: true, completion: nil)
    }
}

extension SettingsPresenter: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {

        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingsPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case .init(row: 0, section: 1):
            print("Rate app")
            askReview()
        case .init(row: 1, section: 1):
            print("Write feedback")
            writeFeedback()
        case .init(row: 0, section: 2):
            print("Write db")
            UIManager.shared.showAlertTwoButtons(title: "Create backup?", message: "You are sure about crating backup to your iCloud?", pressConfirm: {
                self.interactor.createBackup()
            })
        case .init(row: 1, section: 2):
            print("read db")
            UIManager.shared.showAlertTwoButtons(title: "Restore data from iCloud?", message: "ALL unsaved  to backup data will be ERASED and replaced by data from backup. You are sure about restoring data from iCloud?", pressConfirm: {
                self.interactor.restoreFromBackup()
            })
        default:
            break
        }
    }
}

// MARK: -
// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {
    func backupCreated() {
        view.backupCreated()
    }
    
    func restoredFromBackup() {
        view.restoredFromBackup()
    }
    
    func errorProcessing(error: String) {
        view.showAlert(error: error)
    }
}

// MARK: -
// MARK: SettingsModuleInput
extension SettingsPresenter: SettingsModuleInput {

}

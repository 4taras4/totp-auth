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
        view.setSwitch(isEnabled: UserDefaults.standard.bool(forKey: Constants.settings.blur))
    }
    
    func blurSetting(isEnabled: Bool) {
        interactor.setBlur(isEnabled: isEnabled)
    }
    

    func askReview() {
        if let url = URL(string: "https://apps.apple.com/us/app/2pass-totp/id1219919851") {
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
        default:
            break
        }
    }
}

// MARK: -
// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}

// MARK: -
// MARK: SettingsModuleInput
extension SettingsPresenter: SettingsModuleInput {

}

//
//  TouchIDViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 4/12/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

import LocalAuthentication

class TouchIDViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    let kMsgShowFinger = "Scan your finger"
    let kMsgShowReason = "Use TouchID for login"
    let kMsgFingerOK = "Login successfull ✅"
    
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        var policy: LAPolicy?
        if #available(iOS 9.0, *) {
            policy = .deviceOwnerAuthentication
        } else {
            context.localizedFallbackTitle = "Pass"
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        
        var err: NSError?
        
        guard context.canEvaluatePolicy(policy!, error: &err) else {
            image.image = UIImage(named: "TouchID_off")
            message.text = err?.localizedDescription
            return
        }
        image.image = UIImage(named: "TouchID_on")
        message.text = kMsgShowFinger
        loginProcess(policy: policy!)
    }

    
    private func loginProcess(policy: LAPolicy) {
        if #available(iOS 11.0, *) {
            var localizedReason = "Face ID authentication"
            switch context.biometryType {
            case .faceID: localizedReason = "Unlock using Face ID"
            case .touchID: localizedReason = "Unlock using Touch ID"
            case .none: print("No Biometric support")
            }
        } else {
            // Fallback on earlier versions
        }
        context.evaluatePolicy(policy, localizedReason: kMsgShowReason, reply: { (success, error) in
            DispatchQueue.main.async {
                guard success else {
                    guard let error = error else {
                        self.showUnexpectedErrorMessage()
                        return
                    }
                    switch(error) {
                    case LAError.authenticationFailed:
                        self.message.text = "There was a problem verifying your identity."
                    case LAError.userCancel:
                        self.message.text = "Authentication was canceled by user."
                    case LAError.userFallback:
                        self.message.text = "The user tapped the fallback button (Fuu!)"
                    case LAError.systemCancel:
                        self.message.text = "Authentication was canceled by system."
                    case LAError.passcodeNotSet:
                        self.message.text = "Passcode is not set on the device."
                    case LAError.touchIDNotAvailable:
                        self.message.text = "Touch ID is not available on the device."
                    case LAError.touchIDNotEnrolled:
                        self.message.text = "Touch ID has no enrolled fingers."
                    case LAError.touchIDLockout:
                        self.message.text = "There were too many failed Touch ID attempts and Touch ID is now locked."
                    case LAError.appCancel:
                        self.message.text = "Authentication was canceled by application."
                    case LAError.invalidContext:
                        self.message.text = "LAContext passed to this call has been previously invalidated."
                    default:
                        self.message.text = "Touch ID may not be configured"
                        break
                    }
                    return
                }
                self.message.text = self.kMsgFingerOK
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "Main")
                self.present(controller, animated: true, completion: nil)
            }
        })
    }
    
    private func showUnexpectedErrorMessage() {
        image.image = UIImage(named: "TouchID_off")
        message.text = "Unexpected error! 😱"
    }
    
}


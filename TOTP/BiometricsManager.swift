//
//  SecurityManager.swift
//  TOTP
//
//  Created by Taras Markevych on 30.11.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit
import LocalAuthentication

extension LAContext: LAContextProtocol { }
protocol LAContextProtocol {
    func canEvaluatePolicy(_ : LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

enum BioError: Error {
    case General
    case NoEvaluate
}

class BiometricsManager {
    private let context: LAContextProtocol
    
    static let shared = BiometricsManager()
    
    var biometricEnabled: Bool = false
    
    private init(context: LAContextProtocol = LAContext() ) {
        self.context = context
        self.biometricEnabled = UserDefaults.standard.bool(forKey: Constants.settings.biometric)
    }
    
    private func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
   
    private func authenticateUser(completion: @escaping (Result<String, Error>) -> Void) {
        AppDelegate.autoBlur.createBlurEffect()
        guard canEvaluatePolicy() else {
            completion(.failure(BioError.NoEvaluate))
            return
        }
        let loginReason = Constants.text.biometricDescription
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    completion(.success("Success"))
                }
            } else {
                switch evaluateError {
                default: completion(.failure(BioError.General))
                }
            }
        }
    }
    
    func showAuthIfNeeded() {
        if !biometricEnabled {
            return
        }
        BiometricsManager.shared.authenticateUser(completion: { (result) in
            print(result)
            switch result {
            case .success(_):
                print("Authorized")
                AppDelegate.autoBlur.removeBlurEffect()
            case .failure(let error):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    UIManager.shared.showAlert(title: Constants.text.settingsErrorAlertTitle, message: error.localizedDescription)
                })
            }
        })
    }

}

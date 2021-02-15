//
//  MainListMainListInteractor.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//
import OneTimePassword
import Base32

final class MainListInteractor: MainListInteractorInput {
   
	weak var output: MainListInteractorOutput?

    func converUserData(users: [User]) {
        var codes = [Code]()
        var favouritesArray = [Code]()
        for u in users {
            if let c = convertUser(user: u) {
                if u.isFavourite == true {
                    favouritesArray.append(c)
                }
                codes.append(c)
            }
        }
        output?.listOfCodes(codes: codes, favourites: favouritesArray)
    }
    

    func convertUser(user: User) -> Code? {
        guard let secretData = MF_Base32Codec.data(fromBase32String: user.token),
            !secretData.isEmpty else {
                print("Invalid secret")
                return nil
        }

        guard let generator = Generator(
            factor: .timer(period: 30),
            secret: secretData,
            algorithm: .sha1,
            digits: 6) else {
                print("Invalid generator parameters")
                return nil
        }
        
        let token = Token(name: user.name ?? "", issuer: user.issuer ?? "", generator: generator)
        guard let currentCode = token.currentPassword else {
            print("Invalid generator parameters")
            return nil
        }
        return Code(name: user.name, issuer: user.issuer, code: currentCode, token: user.token)
    }
    
    func deleteRow(with token: String?) {
        let alertController = UIAlertController(title: Constants.text.removeBackupAlertTitle, message: Constants.text.removeBackupAlertDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constants.text.cancelAlertButton, style: .cancel)
        let okAction = UIAlertAction(title: Constants.text.removeAlertButton, style: .destructive, handler: { _ in
            guard let item = RealmManager.shared.getUserBy(token: token) else { return }
            RealmManager.shared.removeObject(user: item, completionHandler: { success in
                if success {
                    self.output?.dataBaseOperationFinished()
                }
            })
        })

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        if let topController = UIApplication.topViewController() {
            topController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func updateRow(with token: String?, isFavourite: Bool) {
        guard let item = RealmManager.shared.getUserBy(token: token) else { return }
        RealmManager.shared.saveNewUser(name: item.name, issuer: item.issuer, token: item.token ?? "", isFav: isFavourite, completionHandler: { completed in
            if completed {
                self.output?.dataBaseOperationFinished()
            }
        })
    }
    
    func getFolders() {
        output?.listOfFolders(array: RealmManager.shared.fetchFolders() ?? [])
    }
    
    
}

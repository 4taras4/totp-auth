//
//  FolderDetailsFolderDetailsInteractor.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//
import OneTimePassword
import Base32

final class FolderDetailsInteractor: FolderDetailsInteractorInput {

	weak var output: FolderDetailsInteractorOutput!

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
        output?.listOfCodes(codes: codes)
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
}

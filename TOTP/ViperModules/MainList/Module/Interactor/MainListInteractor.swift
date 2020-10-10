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
        for u in users {
            if let c = convertUser(user: u) {
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
        return Code(name: user.name, issuer: user.issuer, code: currentCode)
    }
}

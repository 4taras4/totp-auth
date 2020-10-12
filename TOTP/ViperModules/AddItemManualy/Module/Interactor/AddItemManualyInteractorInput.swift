//
//  AddItemManualyAddItemManualyInteractorInput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation

protocol AddItemManualyInteractorInput: class {    
    func viewWantsToUpdate(secret: String)
   
    func viewWantsToUpdate(name: String)

    func viewWantsToUpdate(issuer: String)
    
    func save()
}

//
//  AddItemManualyAddItemManualyViewOutput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

protocol AddItemManualyViewOutput: class {
	/// - author: Tarik
	func viewIsReady()
    
    func save()
    
    func viewWantsToUpdate(secret: String)
   
    func viewWantsToUpdate(name: String)

    func viewWantsToUpdate(issuer: String)
}

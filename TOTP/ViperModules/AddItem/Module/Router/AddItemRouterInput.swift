//
//  AddItemAddItemRouterInput.swift
//  TOTP
//
//  Created by Tarik on 10/10/2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation

protocol AddItemRouterInput: class {

    func popToRoot()
    
    func pushManualyViewController()
}

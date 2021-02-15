//
//  FolderDetailsFolderDetailsInteractorOutput.swift
//  TOTP
//
//  Created by Tarik on 15/02/2021.
//  Copyright © 2021 Taras Markevych. All rights reserved.
//

import Foundation

protocol FolderDetailsInteractorOutput: class {
    func listOfCodes(codes: [Code])

}

//
//  Error.swift
//  TOTP
//
//  Created by Taras Markevych on 19.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

enum CloudError: Error {
    case uploadError(String)
    case downloadError(String)
}

//
//  FileManager+Extension.swift
//  TOTP
//
//  Created by Taras Markevych on 16.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit

extension FileManager {
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.settings.appGroup)!
    }
}

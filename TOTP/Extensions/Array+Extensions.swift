//
//  Array+Extensions.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}

extension FileManager {
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.totp.app")!
    }
}

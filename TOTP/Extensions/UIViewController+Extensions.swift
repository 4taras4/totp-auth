//
//  UIVIewController+Extensions.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import SwinjectStoryboard

protocol NibIdentifiable: class {
    static var nibNameIdentifier: String { get }
    static var controllerIdentifier: String { get }
}

// MARK: - Indentifies each storyboard from its classname.
extension NibIdentifiable where Self: UIViewController {

    static func instantiate(useSwinject: Bool = false) -> Self {
        let stb = useSwinject ? SwinjectStoryboard.create(name: Self.nibNameIdentifier, bundle: nil, container: container) : UIStoryboard(name: Self.nibNameIdentifier, bundle: nil)
        guard let viewController = stb.instantiateViewController(withIdentifier: Self.controllerIdentifier) as? Self else {
            fatalError("Can not init \(Self.nibNameIdentifier). Crash")
        }
        return viewController
    }

}

//
//  UIManager.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class UIManager {

    private(set) var window: UIWindow?
    private(set) var tabBarController: UITabBarController?

    static let shared = UIManager()
    // Configure window with main root view controller
    func configure(with window: UIWindow) {
        self.window = window
        let mainListViewController = MainListViewController.instantiate(useSwinject: true)
        let navigation = UINavigationController(rootViewController: mainListViewController)
        navigation.navigationBar.tintColor = .label
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    func present<T: UIViewController>(viewController: T.Type, animated: Bool = false, isNeedNavigation: Bool = false, presentationStyle: UIModalPresentationStyle = .overFullScreen, prepare: ((T) -> ())? = nil) where T: NibIdentifiable {
        present(viewController: viewController,
                useSwinject: false,
                animated: animated,
                isNeedNavigation: isNeedNavigation,
                presentationStyle: presentationStyle,
                beforePresented: prepare,
                afterPresented: nil)
    }

    func present<T: UIViewController>(viewController: T.Type, useSwinject: Bool, animated: Bool, isNeedNavigation: Bool = false, presentationStyle: UIModalPresentationStyle = .overFullScreen, beforePresented: ((T) -> ())? = nil, afterPresented: ((T) -> ())? = nil) where T: NibIdentifiable {
        guard let topController = UIApplication.topViewController() else {
            print("** Error: Couldn't load top view controller **")
            return
        }
        let viewController = T.instantiate(useSwinject: useSwinject)
        if let beforePresented = beforePresented {
            beforePresented(viewController)
        }
        viewController.modalPresentationStyle = presentationStyle
        if isNeedNavigation {
            let navigation = UINavigationController(rootViewController: viewController)
            navigation.modalPresentationStyle = presentationStyle
            topController.present(navigation, animated: animated, completion: nil)
            return
        }
        topController.present(viewController, animated: animated, completion: { afterPresented?(viewController) })
    }

    func push<T: UIViewController>(viewController: T.Type, prepare: ((T) -> ())? = nil) where T: NibIdentifiable {
        guard let topController = UIApplication.topViewController() else {
            print("** Error: Couldn't load top view controller **")
            return
        }
        let viewController = T.instantiate()
        if let prepare = prepare {
            prepare(viewController)
        }
        topController.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setRoot<T: UIViewController>(viewController: T, completed: ((T) -> ())? = nil) where T: NibIdentifiable {
        
        guard let window = window else {
            print("** Hasn't root window **")
            return
        }
        window.makeKeyAndVisible()
        window.rootViewController = viewController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {})
        if let completed = completed {
            completed(viewController)
        }
    }
    
    func dismissTop<T: UIViewController>(viewController type: T.Type, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            if let topController = UIApplication.topViewController() as? T {
                print("Dismiss \(topController)")
                topController.dismiss(animated: animated, completion: {
                    topController.removeFromParent()
                    completion?()
                })
            }
        }
    }
        
    public func showAlert(title: String?, message: String?) {
       DispatchQueue.main.async {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .cancel)
           alertController.addAction(okAction)
           if let topController = UIApplication.topViewController() {
               topController.present(alertController, animated: true, completion: nil)
           }
       }
    }

    func presentLocalNotification(with identifier: String, content: UNNotificationContent) {
        DispatchQueue.main.async {
            let req = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(req)
            
        }
    }

    func removeLocalNotifications(_ identifiers: [String] = []) {
        if identifiers.isEmpty {
            print("***** Remove ALL local notifications *****")

            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        } else {
            print("***** Remove local notifications: \(identifiers) *****")

            UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { notifications in
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiers)
            })
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { notifications in
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            })
        }
    }

    private init() {}

    func isDarkModeEnabled() -> Bool {
          if #available(iOS 13.0, *) {
            return UITraitCollection.current.userInterfaceStyle == .dark
          } else {
            return false
          }
    }
}



extension UIApplication {
    public class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

    public class func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            topViewController()?.present(viewController, animated: animated, completion: completion)
        }
    }
}

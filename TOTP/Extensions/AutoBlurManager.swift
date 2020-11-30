//
//  AutoBlurManager.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import Foundation
import UIKit

public class AutoBlurScreen {
    private var newBlur: UIImageView?

    public var blurStyle: UIBlurEffect.Style = .light
    public var isAutoBlur: Bool = true

    public init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(remoteBlur),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addBlur),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }

    @objc private func addBlur() {
        if isAutoBlur {
            createBlurEffect()
        }
    }

    @objc private func remoteBlur() {
        if isAutoBlur {
            removeBlurEffect()
        }
    }

    public func createBlurEffect() {
        newBlur = UIImageView(frame: UIManager.shared.window!.frame)
        guard let newBlur = newBlur else { return }
        let blurEffect = UIBlurEffect(style: self.blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIManager.shared.window!.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newBlur.addSubview(blurEffectView)
        if let top = UIApplication.topViewController()?.navigationController {
            top.view.addSubview(newBlur)
        } 
    }

    public func removeBlurEffect() {
        if let blur = newBlur {
            let blurredEffectViews = blur.subviews.filter{ $0 is UIVisualEffectView }
            blurredEffectViews.forEach { blurView in
                blurView.removeFromSuperview()
            }
            newBlur = nil
        }
    }
}

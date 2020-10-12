//
//  UIVIewController+Extensions.swift
//  TOTP
//
//  Created by Taras Markevych on 10.10.2020.
//  Copyright © 2020 Taras Markevych. All rights reserved.
//

import SwinjectStoryboard
import GoogleMobileAds

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

extension UIViewController: GADBannerViewDelegate {
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      if #available(iOS 11.0, *) {
        positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
      } else {
        positionBannerViewFullWidthAtBottomOfView(bannerView)
      }
    }
    
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
      // Position the banner. Stick it to the bottom of the Safe Area.
      // Make it constrained to the edges of the safe area.
      let guide = view.safeAreaLayoutGuide
      NSLayoutConstraint.activate([
        guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
        guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
        guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
      ])
    }

    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .leading,
                                            multiplier: 1,
                                            constant: 0))
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .trailing,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: .trailing,
                                            multiplier: 1,
                                            constant: 0))
      view.addConstraint(NSLayoutConstraint(item: bannerView,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: bottomLayoutGuide,
                                            attribute: .top,
                                            multiplier: 1,
                                            constant: 0))
    }
    
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    public func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    public func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    public func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    public func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    public func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}


extension UIImage {
    func mergeImages(top: UIImage) -> UIImage {
        let size = CGSize(width: 300, height: 300)
        UIGraphicsBeginImageContext(size)
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.draw(in: areaSize)
        top.draw(in: areaSize, blendMode: .normal, alpha: 0.8)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

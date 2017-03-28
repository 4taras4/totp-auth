//
//  FirstLoginViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 3/27/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit
import Crashlytics

class FirstLoginViewController: UIViewController {
    let defaults = UserDefaults.standard

    @IBOutlet weak var skipButton: UIButton!
    @IBAction func skipAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
        defaults.set(true, forKey: "firstLoad")
        defaults.synchronize()
        Answers.logContentView(withName: "Logged", contentType: "Button", contentId: "1", customAttributes: ["Favorites Count":20, "Screen Orientation":"Portrait"])

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

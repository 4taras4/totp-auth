//
//  FirstLoginViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 3/27/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class FirstLoginViewController: UIViewController {
    let defaults = UserDefaults.standard

    @IBOutlet weak var skipButton: UIButton!
    @IBAction func skipAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(controller, animated: true, completion: nil)
        defaults.set(true, forKey: "firstLoad")
        defaults.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

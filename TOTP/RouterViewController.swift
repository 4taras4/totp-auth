//
//  RouterViewController.swift
//  TOTP
//
//  Created by Taras Markevych on 4/12/17.
//  Copyright © 2017 Taras Markevych. All rights reserved.
//

import UIKit

class RouterViewController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadFirstViewStory()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func loadFirstViewStory()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let touthId = defaults.object(forKey: "touchID") as! String?
        if defaults.object(forKey: "firstLoad") == nil {
            let controller = storyboard.instantiateViewController(withIdentifier: "FirstLogin")
            self.present(controller, animated: true, completion: nil)
        } else if touthId == "1" {
            let controller = storyboard.instantiateViewController(withIdentifier: "Security")
            self.present(controller, animated: true, completion: nil)
        } else {
            let controller = storyboard.instantiateViewController(withIdentifier: "Main")
            self.present(controller, animated: true, completion: nil)
        }
    }

}

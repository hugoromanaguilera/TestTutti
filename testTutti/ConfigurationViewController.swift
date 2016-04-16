//
//  ConfigurationViewController.swift
//  testTutti
//
//  Created by hugo roman on 7/8/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import  UIKit

class ConfigurationViewController: UIViewController {
    
    //for url only
    var ret : ConnectionResult = .NoCredentials
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBAction func uGOForgetMe(sender: AnyObject) {
        print(myUtils.currentTimeMillis())
        uGoClient.sharedInstance().uGOForgetMe()
        userNameLabel.text = "N/I"
        print(myUtils.currentTimeMillis())
        performSegueWithIdentifier("unwindToMenu", sender: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = uGoClient.sharedInstance().settings.user
    }
    
    override func viewDidAppear(animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }
}



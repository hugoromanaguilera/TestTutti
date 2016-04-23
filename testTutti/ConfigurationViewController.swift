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
    
    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    @IBAction func uGOForgetMe(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivity.hidden = true
        userNameLabel.text = uGoClient.sharedInstance().settings.user
    }
    
    override func viewDidAppear(animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "unwindToMenu") {
            
            print(myUtils.currentTimeMillis())
            myActivity.hidden = false
            myActivity.startAnimating()
            uGoClient.sharedInstance().uGOForgetMe()
            userNameLabel.text = "N/I"
            print(myUtils.currentTimeMillis())
            myActivity.hidden = true
            myActivity.stopAnimating()
            
            let yourNextViewController = (segue.destinationViewController as! LoginViewController)
            yourNextViewController.userTextField.text = ""
            yourNextViewController.passwordTextField.text = ""

        }
    }
    
}



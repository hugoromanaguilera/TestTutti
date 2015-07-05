//
//  Login.swift
//  testTutti
//
//  Created by hugo roman on 7/3/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//
//

import Foundation
import UIKit


class LoginViewController: UIViewController {
    
    //for url only
    let urlIn :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc"
    var dataOut:String = ""

    @IBOutlet var userTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!

    @IBOutlet var loginButton: UIButton!
    
    @IBAction func loginPressed(sender: AnyObject) {

        let usr = self.userTextField.text!
        let pwd = self.passwordTextField.text!
        var ret : ConnectionResult = .NoCredentials
        
        if (usr != "" && pwd != "") {
            //validate svc and if ok insert or update account
            mySession.settings.user = usr
            mySession.settings.password = pwd
            var localUrl :String = urlIn
            self.dataOut = Utils.connectToSvc(localUrl, lsUserAndPassword: (usr + ":" + pwd), completed: &ret)
            if (ret == .Success){
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (mySession.settings.user != "" && mySession.settings.password != "") {
            var localUrl :String = urlIn
            var ret : ConnectionResult = .NoCredentials
            self.dataOut = Utils.connectToSvc(localUrl, lsUserAndPassword: (mySession.settings.user! + ":" + mySession.settings.password!), completed: &ret)
            if (ret == .Success){
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }
    override func viewDidAppear(animated: Bool) {
        //
    }
    override func viewDidDisappear(animated: Bool) {
        //
    }
    
    
}



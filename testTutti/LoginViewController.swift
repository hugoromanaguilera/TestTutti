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


class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
            println(Utils.currentTimeMillis())
            var ret:ConnectionResult = .NoCredentials
            println(Utils.currentTimeMillis())
            mySession.uGOLogin(&ret)
            if (ret == .Success){
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        passwordTextField.delegate = self
        
        if let usr = mySession.settings.user {
            if let pwd = mySession.settings.password {
                if (usr != "" && pwd != "" ){
                    println(Utils.currentTimeMillis())
                    var ret:ConnectionResult = .NoCredentials
                    println(Utils.currentTimeMillis())
                    mySession.uGOLogin(&ret)
                    if (ret == .Success){
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //
    }
    
    override func viewDidDisappear(animated: Bool) {
        //
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
}



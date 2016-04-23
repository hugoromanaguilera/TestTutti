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
        uGoClient.sharedInstance().settings.user = userTextField.text
        uGoClient.sharedInstance().settings.password = passwordTextField.text
        logueate()
    }

    @IBOutlet weak var myActivity: UIActivityIndicatorView!
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myActivity.hidden = true
        userTextField.delegate = self
        passwordTextField.delegate = self
        logueate()
    }

    func logueate ()-> Void{
        if let usr = uGoClient.sharedInstance().settings.user {
            if let pwd = uGoClient.sharedInstance().settings.password {
                if (usr != "" && pwd != "" ){
                    myActivity.hidden = false
                    userTextField.text = usr
                    passwordTextField.text = pwd
                    print(myUtils.currentTimeMillis())
                    uGoClient.sharedInstance().uGoLogin(){(result, error) -> Void in
                        self.myActivity.hidden = true
                        if let _ = result as ConnectionResult! {
                            uGoClient.sharedInstance().isConnected = true
                            if (result == ConnectionResult.Success){
                                dispatch_async(dispatch_get_main_queue(), {
                                    print(myUtils.currentTimeMillis())
                                    self.performSegueWithIdentifier("login2DetailSegue", sender: self)
                                })
                            }
                            if (result == ConnectionResult.ServerError){
                                CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "Error en servidor uGo", myActionTitle: "Error", myActionStyle: .Default)
                            }
                            if (result == ConnectionResult.NoCredentials){
                                CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "Error en credenciales uGo", myActionTitle: "Error", myActionStyle: .Default)
                            }
                            if (result == ConnectionResult.TimeOut){
                                CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "uGo con time out", myActionTitle: "Error", myActionStyle: .Default)
                            }
                            if (result == ConnectionResult.NoConnection){
                                CommonHelpers.presentOneAlertController(self, alertTitle: "Error", alertMessage: "uGo sin comunicación", myActionTitle: "Error", myActionStyle: .Default)
                            }
                        }
                    }
                }
            }
        }
        
    }
    override func viewDidAppear(animated: Bool) {
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



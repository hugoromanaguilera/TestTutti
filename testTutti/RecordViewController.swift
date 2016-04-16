//
//  RecordViewController.swift
//  testTutti
//
//  Created by hugo roman on 7/8/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity

class RecordViewController: UIViewController, WCSessionDelegate {
    //for url only
    var ret : ConnectionResult = .NoCredentials
    var session: WCSession!
    
    @IBOutlet weak var lastAccessLabel: UILabel!
    
    @IBAction func uGOInPressed(sender: AnyObject) {
        print(myUtils.currentTimeMillis())
        uGoClient.sharedInstance().myLocation.showMyLocation()
        uGoClient.sharedInstance().uGOIn() {(result, error) -> Void in
            if let _ = result as ConnectionResult! {
                uGoClient.sharedInstance().isConnected = true
                if (result == ConnectionResult.Success){
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
            if result == ConnectionResult.Success {
                
            }
        }
        uGoClient.sharedInstance().settings.lastArrival = NSDate()
        print(myUtils.currentTimeMillis())
    }
    
    @IBAction func uGoOutPressed(sender: AnyObject) {
        print(myUtils.currentTimeMillis())
        uGoClient.sharedInstance().myLocation.showMyLocation()
        uGoClient.sharedInstance().uGOOut() {(result, error) -> Void in
            if let _ = result as ConnectionResult! {
                uGoClient.sharedInstance().isConnected = true
                if (result == ConnectionResult.Success){
                    dispatch_async(dispatch_get_main_queue(), {
                        print(myUtils.currentTimeMillis())
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
        uGoClient.sharedInstance().settings.lastDeparture = NSDate()
        print(myUtils.currentTimeMillis())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        if (WCSession.isSupported()) {
            session = WCSession.defaultSession()
            session.delegate = self;
            session.activateSession()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mi"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        if let _ = uGoClient.sharedInstance().settings.lastArrival {
            lastAccessLabel.text = "Last in: " + dateFormatter.stringFromDate(uGoClient.sharedInstance().settings.lastArrival!) + " | "
        } else
        {
            lastAccessLabel.text = "Last in: N/I | "
        }
        if let _ = uGoClient.sharedInstance().settings.lastDeparture {
            lastAccessLabel.text = lastAccessLabel.text! + "Last out: " + dateFormatter.stringFromDate(uGoClient.sharedInstance().settings.lastDeparture!)
        } else
        {
            lastAccessLabel.text = lastAccessLabel.text! + "Last out: N/I"
        }
    }
    
    override func viewWillAppear(animated: Bool) {
//        uGoClient.sharedInstance().myLocation.showMyLocation()
    }
    
    override func viewDidDisappear(animated: Bool) {
//        uGoClient.sharedInstance().myLocation.hideMyLocation()
    }
    
    
    //Swift
    func sessionWatchStateDidChange(session: WCSession) {
        print(#function)
        print(session)
        print("reachable:\(session.reachable)")
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        let actionCode = message["action"] as? String
        if actionCode == "uGoIn"{
            uGoInFromWatch({ (registered) -> Void in
                replyHandler(["uGoIn":registered])
            })
        }
        if actionCode == "uGoOut"{
            uGoOutFromWatch({ (registered) -> Void in
                replyHandler(["uGoOut":registered])
            })
        }
    }

    func uGoInFromWatch(completionHandler:(registered: Bool)->Void)->Void {
        uGoClient.sharedInstance().uGOIn() {(result, error) -> Void in
            if let _ = result as ConnectionResult! {
                if result == ConnectionResult.Success {
                    completionHandler(registered: true)
                }else
                {
                    completionHandler(registered: false)
                }
                return
            }
        }
        
    }

    func uGoOutFromWatch(completionHandler:(registered: Bool)->Void)->Void {
        uGoClient.sharedInstance().uGOOut() {(result, error) -> Void in
            if let _ = result as ConnectionResult! {
                if result == ConnectionResult.Success {
                    completionHandler(registered: true)
                }else
                {
                    completionHandler(registered: false)
                }
                return
            }
        }
        
    }

}


//
//  registerController.swift
//  testTutti
//
//  Created by hugo roman on 12/28/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//


import WatchKit
import Foundation
import WatchConnectivity

class registerController: WKInterfaceController, WCSessionDelegate {
    
    var session : WCSession!
    var myTaptics : tapticsCall! = tapticsCall()
    
    @IBOutlet var inButton: WKInterfaceButton!
    @IBOutlet var mySeparator: WKInterfaceSeparator!
    @IBOutlet var outButton: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    @IBAction func registerInButtonPressed() {
        print(myUtils.currentTimeMillis())
        mySeparator.setColor(UIColor.whiteColor())
        let applicationData = ["action":"uGoIn"]
        if WCSession.isSupported(){
            session.sendMessage(applicationData, replyHandler: {(result: [String : AnyObject]) -> Void in
                let returnCode = result["uGoIn"] as? Bool
                if returnCode! {
                    self.mySeparator.setColor(UIColor.greenColor())
                    self.myTaptics.giveSuccess()
                }else
                {
                    self.mySeparator.setColor(UIColor.redColor())
                    self.myTaptics.giveFailure()
                }
                // handle reply from iPhone app here
                }, errorHandler: {(error ) -> Void in
                    self.myTaptics.giveFailure()
                })
            print(myUtils.currentTimeMillis())
        }
    }
    
    @IBAction func registerOutButtonPressed() {
        print(myUtils.currentTimeMillis())
        let applicationData = ["action":"uGoOut"]
        self.mySeparator.setColor(UIColor.whiteColor())
        if WCSession.isSupported(){
            session.sendMessage(applicationData, replyHandler: {(result: [String : AnyObject]) -> Void in
                let returnCode = result["uGoOut"] as? Bool
                if returnCode! {
                    self.mySeparator.setColor(UIColor.greenColor())
                    self.myTaptics.giveSuccess()
                }else
                {
                    self.mySeparator.setColor(UIColor.redColor())
                    self.myTaptics.giveFailure()
                }
                // handle reply from iPhone app here
                }, errorHandler: {(error ) -> Void in
                    // catch any errors here
            })
            print(myUtils.currentTimeMillis())
        }
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self // conforms to WCSessionDelegate
            session.activateSession()
            self.mySeparator.setColor(UIColor.blackColor())
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}

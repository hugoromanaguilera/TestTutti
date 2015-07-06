//
//  ViewController.swift
//  testTutti
//
//  Created by hugo roman on 6/29/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    @IBOutlet var latLabel: UILabel!
    
    @IBOutlet var lonLabel: UILabel!
    
    @IBOutlet var conLabel: UILabel!

    @IBOutlet var beaconLabel: UILabel!

//for url only
    var ret : ConnectionResult = .NoCredentials
    
    
//for use testing
    @IBAction func testButton(sender: AnyObject) {
        if Reachability.isConnectedToNetwork() {
            conLabel.backgroundColor = UIColor.greenColor()        }
        else
        {
            conLabel.backgroundColor = UIColor.redColor()
        }
    }
    
    @IBAction func setButton(sender: AnyObject) {
/*
        localMgr  = CLLocationManager()
        localMgr.delegate = self
        localMgr.desiredAccuracy = kCLLocationAccuracyBest
        localMgr.requestAlwaysAuthorization()
*/
}
    
    @IBAction func startButton(sender: AnyObject) {
//        localMgr.startUpdatingLocation()
//        localMgr.startMonitoringSignificantLocationChanges()
    }
    
    @IBAction func stopButton(sender: AnyObject) {
//            localMgr.stopUpdatingLocation()
    }

    @IBAction func setBeacon(sender: AnyObject) {
    }
    
    @IBAction func startBeacon(sender: AnyObject) {
        myBeacon.startBeacons()
    }

    @IBAction func stopBeacon(sender: AnyObject) {
        myBeacon.stopBeacons()
}
    
    @IBAction func uGOInPressed(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var ret:ConnectionResult = .NoCredentials
        mySession.uGOIn(&ret)
        println(Utils.currentTimeMillis())
    }
    
    @IBAction func uGoOutPressed(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var ret:ConnectionResult = .NoCredentials
        mySession.uGOOut(&ret)
        println(Utils.currentTimeMillis())
    }
    
    @IBAction func uGOHistory(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var ret:ConnectionResult = .NoCredentials
        mySession.uGOHistory(&ret)
        println(Utils.currentTimeMillis())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        //
    }

    override func viewDidDisappear(animated: Bool) {
        //
    }
}



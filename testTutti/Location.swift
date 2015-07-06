//
//  Location.swift
//  testTutti
//
//  Created by hugo roman on 7/5/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    
    //for location
    var localMgr: CLLocationManager!
    var localPos: CLLocation!
    var locationFixAchieved = false
    var locationStatus : String = ""
    
    override init() {
        super.init()
        localMgr  = CLLocationManager()
        localMgr.delegate = self
        localMgr.desiredAccuracy = kCLLocationAccuracyBest
        localMgr.requestAlwaysAuthorization()
        self.startLocationManager()
    }

    func ping()->Void{
        
    }
    
    func startLocationManager()->Void{
        localMgr.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        //        if (locationFixAchieved == false) {
        locationFixAchieved = true
        var locationArray = locations as NSArray
        var locationObj = locationArray.lastObject as! CLLocation!
        localPos = locationObj
        //            println(localPos.coordinate.latitude)
        //            println(localPos.coordinate.longitude)
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                localMgr.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
    
}

let myLocation = Location()


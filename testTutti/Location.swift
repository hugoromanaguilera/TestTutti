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
    var localPos: CLLocation?
    var locationFixAchieved = false
    var locationStatus : String = ""
    
    override init() {
        super.init()
        localMgr  = CLLocationManager()
        localMgr.delegate = self
        localMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        localMgr.requestAlwaysAuthorization()
        localMgr.startUpdatingLocation()
    }
    
    func showMyLocation(){
        localMgr.requestLocation()
    }

    func hideMyLocation(){
        localMgr.stopUpdatingLocation()
    }
    
    func startMyLocation(){
        localMgr.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Current location: \(locations)")
        if let location = locations.first {
            localPos = location
        } else {
        }
    }
    
    // authorization status
    func locationManager(manager: CLLocationManager,
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
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
}


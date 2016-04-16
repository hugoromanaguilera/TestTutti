//
//  Beacon.swift
//  testTutti
//
//  Created by hugo roman on 7/6/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

/*
import Foundation
import CoreLocation
import CoreBluetooth


class Beacon: NSObject, CLLocationManagerDelegate, CBPeripheralManagerDelegate {
    
    //for location
    var localMgr: CLLocationManager!
    var localPos: CLLocation!
    var locationFixAchieved = false
    var locationStatus : String = ""

    //for beacons only
    let uuidString:String = "11E44F09-4EC4-407E-9203-CF57A50FBCE0"
    let beaconIdentifier:String = "getGelo.com"
    var myBTManager:CBPeripheralManager!
    var advertisedData:[NSDictionary]!
    var _broadcastBeaconDict : Dictionary<String, String>? = nil
    
    override init() {
        super.init()
        myBTManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func ping()->Void{
        
    }
    
    func startLocationManager()->Void{
        localMgr.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        if (locationFixAchieved == false) {
        locationFixAchieved = true
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation!
        localPos = locationObj
        //            println(localPos.coordinate.latitude)
        //            println(localPos.coordinate.longitude)
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
                localMgr.startUpdatingLocation()
            } else {
                NSLog("Denied access: \(locationStatus)")
            }
    }

    //MARK locationManagerBeacons
    
    func locationManager(localMgr: CLLocationManager,
        didRangeBeacons beacons: [CLBeacon],
        inRegion region: CLBeaconRegion) {
            print("didRangeBeacons ");
    var message:String = ""
    
    if(beacons.count > 0) {
        let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
        switch nearestBeacon.proximity {
        case CLProximity.Far:
            message = "You are far away from the beacon"
//        beaconLabel.backgroundColor = UIColor.redColor()
        case CLProximity.Near:
            message = "You are near the beacon \(nearestBeacon.minor) "
//        beaconLabel.backgroundColor = UIColor.yellowColor()
        case CLProximity.Immediate:
            message = "You are in the immediate proximity of the beacon"
//        beaconLabel.backgroundColor = UIColor.greenColor()
        case CLProximity.Unknown:
//        beaconLabel.backgroundColor = UIColor.whiteColor()
        return
    }
    } else
    {
//        beaconLabel.backgroundColor = UIColor.whiteColor()
        message = "No beacons are nearby"
    }
    
    print(message)
    //sendLocalNotificationWithMessage(message)
    }
    
    func startBeacons()->Void{
        let beaconUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        localMgr = CLLocationManager()
        if(localMgr!.respondsToSelector("requestAlwaysAuthorization")) {
            localMgr!.requestAlwaysAuthorization()
        }
        localMgr!.delegate = self
        localMgr!.pausesLocationUpdatesAutomatically = false
        localMgr!.startMonitoringForRegion(beaconRegion)
        localMgr!.startRangingBeaconsInRegion(beaconRegion)
        localMgr!.startUpdatingLocation()
    }
    
    func stopBeacons()->Void{
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        localMgr!.stopMonitoringForRegion(beaconRegion)
        localMgr!.stopRangingBeaconsInRegion(beaconRegion)
        localMgr!.stopUpdatingLocation()
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {

        if peripheral.state == CBPeripheralManagerState.PoweredOn {
            print("BT Broadcasting...")
    //start broadcasting
            myBTManager!.startAdvertising(_broadcastBeaconDict)
        } else if peripheral.state == CBPeripheralManagerState.PoweredOff {
            print("BT Stopped")
    //Pedir que se active el BT
            myBTManager!.stopAdvertising()
        } else if peripheral.state == CBPeripheralManagerState.Unsupported {
            print("BT Unsupported")
        } else if peripheral.state == CBPeripheralManagerState.Unauthorized {
            print("BT This option is not allowed by your application")
        }
        }
}

let myBeacon = Beacon()
*/

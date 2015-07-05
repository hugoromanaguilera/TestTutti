//
//  ViewController.swift
//  testTutti
//
//  Created by hugo roman on 6/29/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreBluetooth


class ViewController: UIViewController, CLLocationManagerDelegate, CBPeripheralManagerDelegate {

    @IBOutlet var latLabel: UILabel!
    
    @IBOutlet var lonLabel: UILabel!
    
    @IBOutlet var conLabel: UILabel!

    @IBOutlet var beaconLabel: UILabel!

//for sec
    let localUserPasswordString : String = "hroman:javierA17"
    
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
//for url only
    let urlIn :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
    let urlOut:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
    let urlHistory:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/LeerAsistenciaUltimosDias?$format=json"
    var dataOut:String = ""
    var ret : ConnectionResult = .NoCredentials
    
//for nicator
    func hoyEs()->String{
        var todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
        let toArray = DateInFormat.componentsSeparatedByString(" ")
        let fecha = "datetime'"+join("T", toArray)+"'"
        return (fecha)
    }

    func setParams (loc:CLLocation, lTipoEvento:String)->[String: AnyObject]{
        var params:[String:AnyObject] = ["fch_dispositivo": hoyEs(), "nro_retraso_sec":0, "val_latitud":"0M", "val_longitud":"0M", "val_altura":"0", "val_precision":"0", "tipo_evento":"'" + lTipoEvento + "'", "tipo_dispositivo":"'I'", "es_mock_location": "true", "es_registro_offline": "false", "beacon_primario_major": "", "beacon_primario_minor": "", "beacon_secundario_major": "", "beacon_secundario_minor": 0]
        
        params["es_mock_location"] = "false"
        params["val_latitud"] = "\(loc.coordinate.latitude)M"
        params["val_longitud"] = "\(loc.coordinate.longitude)M"
        params["val_altura"] = loc.altitude
        params["val_precision"] = loc.horizontalAccuracy
        return (params)
    }

    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)[]", value)
            }
        } else {
            components.extend([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    
    func query(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in sorted(Array(parameters.keys), <) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return join("&", components.map{"\($0)=\($1)"} as [String])
    }
    
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
        localMgr  = CLLocationManager()
        localMgr.delegate = self
        localMgr.desiredAccuracy = kCLLocationAccuracyBest
        localMgr.requestAlwaysAuthorization()
    }
    
    @IBAction func startButton(sender: AnyObject) {
//        localMgr.startUpdatingLocation()
        localMgr.startMonitoringSignificantLocationChanges()
    }
    
    @IBAction func stopButton(sender: AnyObject) {
            localMgr.stopUpdatingLocation()
    }

    @IBAction func setBeacon(sender: AnyObject) {
    }
    
    @IBAction func startBeacon(sender: AnyObject) {
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

    @IBAction func stopBeacon(sender: AnyObject) {
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)!
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID,
            identifier: beaconIdentifier)
        localMgr!.stopMonitoringForRegion(beaconRegion)
        localMgr!.stopRangingBeaconsInRegion(beaconRegion)
        localMgr!.stopUpdatingLocation()
    }
    
    @IBAction func uGOInPressed(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var localUrl :String = urlIn + "?" + query(setParams(localPos,lTipoEvento:"I"))
        self.dataOut = Utils.connectToSvc(localUrl, lsUserAndPassword: localUserPasswordString, completed:&ret)
        println(Utils.currentTimeMillis())
    }
    
    @IBAction func uGoOutPressed(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var localUrl :String = urlOut + "?" + query(setParams(localPos,lTipoEvento:"S"))
        self.dataOut = Utils.connectToSvc(localUrl, lsUserAndPassword: localUserPasswordString, completed: &ret)
        println(Utils.currentTimeMillis())
    }
    
    @IBAction func uGOHistory(sender: AnyObject) {
        println(Utils.currentTimeMillis())
        var localUrl :String = urlHistory
        self.dataOut = Utils.connectToSvc(localUrl, lsUserAndPassword: localUserPasswordString, completed:&ret)
        println(Utils.currentTimeMillis())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBTManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    override func viewDidAppear(animated: Bool) {
        //
    }

    override func viewDidDisappear(animated: Bool) {
        //
    }
    
    //MARK locationManager
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        if (locationFixAchieved == false) {
            locationFixAchieved = true
            var locationArray = locations as NSArray
            var locationObj = locationArray.lastObject as! CLLocation!
            localPos = locationObj
//            println(localPos.coordinate.latitude)
//            println(localPos.coordinate.longitude)
            self.latLabel.text = String(format: "%f", localPos.coordinate.latitude)
            self.lonLabel.text = String(format: "%f", localPos.coordinate.longitude)
//        }
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
    
    //MARK locationManagerBeacons
    
    func locationManager(localMgr: CLLocationManager!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            println("didRangeBeacons ");
            var message:String = ""
            
            if(beacons.count > 0) {
                let nearestBeacon:CLBeacon = beacons[0] as! CLBeacon
                switch nearestBeacon.proximity {
                case CLProximity.Far:
                    message = "You are far away from the beacon"
                    beaconLabel.backgroundColor = UIColor.redColor()
                case CLProximity.Near:
                    message = "You are near the beacon \(nearestBeacon.minor) "
                    beaconLabel.backgroundColor = UIColor.yellowColor()
                case CLProximity.Immediate:
                    message = "You are in the immediate proximity of the beacon"
                    beaconLabel.backgroundColor = UIColor.greenColor()
                case CLProximity.Unknown:
                    beaconLabel.backgroundColor = UIColor.whiteColor()
                    return
                }
            } else {
                beaconLabel.backgroundColor = UIColor.whiteColor()
                message = "No beacons are nearby"
            }
            
            println(message)
            //sendLocalNotificationWithMessage(message)
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        if peripheral.state == CBPeripheralManagerState.PoweredOn {
            println("BT Broadcasting...")
            //start broadcasting
//            myBTManager!.startAdvertising(_broadcastBeaconDict)
        } else if peripheral.state == CBPeripheralManagerState.PoweredOff {
            println("BT Stopped")
//      Pedir que se active el BT
//            myBTManager!.stopAdvertising()
        } else if peripheral.state == CBPeripheralManagerState.Unsupported {
            println("BT Unsupported")
        } else if peripheral.state == CBPeripheralManagerState.Unauthorized {
            println("BT This option is not allowed by your application")
        }
    }
}



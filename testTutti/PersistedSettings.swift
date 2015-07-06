//
//  PersistedSettings.swift
//  BeepIn
//
//  Created by Carlos Orrego on 9/23/14.
//  Copyright (c) 2014 Carlos Orrego. All rights reserved.
//

import Foundation

class PersistedSettings{
    private let lastArrivalKey = "lastArrival"
    private let lastDepartureKey = "lastDeparture"
    private let userKey = "uGoUser"
    private let passKey = "uGoPassword"
    private let lastOnlineKey = "lastOnline"
    private let defaults : NSUserDefaults
    
    private var _lastArrival : NSDate?
    private var _lastDeparture : NSDate?
    private var _user : String?
    private var _password : String?
    private var _lastOnline : NSDate?
    
    // singleton
    class var sharedInstance : PersistedSettings {
        struct Static {
            static let instance : PersistedSettings = PersistedSettings()
        }
        return Static.instance
    }
    
    var lastArrival : NSDate?{
        get{
            return _lastArrival
        }
        set(newArrival){
            _lastArrival = newArrival
            defaults.setObject(newArrival, forKey: lastArrivalKey)
            defaults.synchronize()
        }
    }
    
    var lastDeparture : NSDate?{
        get{
            return _lastDeparture
        }
        set(newDeparture){
            _lastDeparture = newDeparture
            defaults.setObject(newDeparture, forKey: lastDepartureKey)
            defaults.synchronize()
        }
    }
    
    var user : String?{
        get{
            return _user
        }
        set(newUser){
            _user = newUser
            defaults.setObject(newUser, forKey: userKey)
            defaults.synchronize()
        }
    }
    
    var password : String?{
        get{
            return _password
        }
        set(newPass){
            _password = newPass
            defaults.setObject(newPass, forKey: passKey)
            defaults.synchronize()
        }
    }
    var userAndPassword : String?{
        get{
            return (user! + ":" + password!)
        }
    }
    
    var lastOnline : NSDate?{
        get{
            return _lastOnline
        }
        set(newOnline){
            println(newOnline)
            _lastOnline = newOnline
            defaults.setObject(newOnline, forKey: lastOnlineKey)
            defaults.synchronize()
        }
    }
    
    init(){
        defaults = NSUserDefaults.standardUserDefaults()
        _lastArrival = defaults.objectForKey(lastArrivalKey) as? NSDate
        _lastDeparture = defaults.objectForKey(lastDepartureKey) as? NSDate
        _user = defaults.objectForKey(userKey) as? String
        _password = defaults.objectForKey(passKey) as? String
        _lastOnline = defaults.objectForKey(lastOnlineKey) as? NSDate
    }
}
//
//  uGoClient.swift
//  testTutti
//
//  Created by hugo roman on 2/13/16.
//  Copyright © 2016 hugo roman. All rights reserved.
//

import Foundation

class uGoClient: NSObject, NSURLSessionDelegate {
    
    /* Shared session */
    var session: NSURLSession
    
    /* Authentication state */
    var sessionID : String? = nil
    var userID : Int? = nil
    var isConnected = false
    var settings : PersistedSettings! = PersistedSettings()
    var myHistoryRecords: [Mark] = []
    var myLocation : Location!

    //MARK: Xml parsing
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    // MARK: Initializers
    override init() {
        session = NSURLSession.sharedSession()
        myLocation = Location()
        super.init()
    }

    // MARK: Shared Instance
    class func sharedInstance() -> uGoClient {
        
        struct Singleton {
            static var sharedInstance = uGoClient()
        }
        
        return Singleton.sharedInstance
    }
    
}
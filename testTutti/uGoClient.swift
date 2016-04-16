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
    var myHistoryRecords: [RecordCard] = []
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
    
    func taskForGETImage(filePath: String, completionHandler: (imageData: NSData?, error: NSError?) ->  Void) -> NSURLSessionTask {
        
        /* 1. Set the parameters */
        // There are none...
        
        /* 2/3. Build the URL and configure the request */
        let url = NSURL(string: filePath)
        let request = NSURLRequest(URL: url!)
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let response = response as? NSHTTPURLResponse {
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                } else if let response = response {
                    print("Your request returned an invalid response! Response: \(response)!")
                } else {
                    print("Your request returned an invalid response!")
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            completionHandler(imageData: data, error: nil)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> uGoClient {
        
        struct Singleton {
            static var sharedInstance = uGoClient()
        }
        
        return Singleton.sharedInstance
    }
    
}
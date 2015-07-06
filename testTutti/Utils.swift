//
//  Utils.swift
//  testTutti
//
//  Created by hugo roman on 6/29/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation

public class Utils {

    class func getCurrentTime() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .FullStyle
        var stringValue = formatter.stringFromDate(date)
        return stringValue
    }
    
    class func currentTimeMillis() -> Int64{
        var nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    class func connectToSvc(lsUrl : String, lsUserAndPassword : String, inout completed:ConnectionResult) -> String{
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let userPasswordData = lsUserAndPassword.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(nil)
        let authString = "Basic  \(base64EncodedCredential) "
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        let session = NSURLSession(configuration: config)
        
        var running = false
        var retorno : String = ""
        
        let url = NSURL(string: lsUrl)
        println(Utils.currentTimeMillis())
        println("Url \(lsUrl)")
        let task = session.dataTaskWithURL(url!) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {

                if let hasError = error {
                    switch error!.code{
                    case -999:
                        completed = .NoCredentials
                        println("noCredentials")
                    default:
                        completed = .ServerError
                        println("serverError")
                    }
                } else {
                    switch httpResponse.statusCode {
                    case 200:
                        completed = .Success
                        println("success")
                    case 401:
                        completed = .NoCredentials
                        println("noCredentials")
                    case 500:
                        completed = .ServerError
                        println("serverError")
                    default:
                        completed = .ServerError
                        println("serverError")
                    }
                }
                println("completed: \(completed)")
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                println(dataString)
                println(Utils.currentTimeMillis())
                if let retValue = (dataString as? String) {
                    retorno = retValue
                }
            }
            running = false
        }
        
        running = true
        task.resume()
        while running {
            }
        return (retorno)
    }

}


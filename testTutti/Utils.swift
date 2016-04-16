//
//  Utils.swift
//  testTutti
//
//  Created by hugo roman on 6/29/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation

enum ConnectionResult{
    case Success
    case NoCredentials
    case NoConnection
    case ServerError
    case TimeOut
}

class Utils: NSObject, NSURLSessionDelegate {

    var session : NSURLSession!
    var withResponse : Bool! = false
    var withTimeOut : Bool! = false
    
    let timeOut : Double = 10
    
    func getCurrentTime() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.timeStyle = .FullStyle
        let stringValue = formatter.stringFromDate(date)
        return stringValue
    }
    
    func currentTimeMillis() -> Int64{
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }

    func connectToSvc(lsUrl : String, inout completed:ConnectionResult) -> String{
        
        withResponse = false
        withTimeOut = false
        let lsUserAndPassword : String = ""
//        let lsUserAndPassword : String = mySession.settings.user! + ":" + mySession.settings.password!
//        let lsUserAndPassword : String = "roberto" + ":" + "carlos"
        let userPasswordData = lsUserAndPassword.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
        let authString = "Basic  \(base64EncodedCredential) "
        if session == nil {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.timeoutIntervalForRequest = timeOut
            config.timeoutIntervalForResource = timeOut
            config.requestCachePolicy = .ReloadIgnoringLocalCacheData
            config.HTTPAdditionalHeaders = ["Authorization" : authString]
            session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.currentQueue())
        }
        
        var retorno : String = ""
        
        print(lsUserAndPassword)
        print("Url \(lsUrl)")
        session.dataTaskWithURL(NSURL(string: lsUrl)!)
            { (data, response, error) in
            guard error == nil
                else {
                    switch error!.code{
                    case -999:
                        completed = .NoCredentials
                        print("noCredentials")
                    default:
                        completed = .ServerError
                        print("serverError")
                    }
                    return
            }
            guard let response = response as? NSHTTPURLResponse
                else {
                    NSLog("not an HTTP response")
                    return
            }
            switch response.statusCode {
                case 200:
                    completed = .Success
                    print("success")
                case 401:
                    completed = .NoCredentials
                    print("noCredentials")
                case 408:
                    completed = .TimeOut
                    print("timeOut")
                case 500:
                    completed = .ServerError
                    print("serverError")
                default:
                    completed = .ServerError
                    print("serverError")
                }
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if let retValue = (dataString as? String) {
                retorno = retValue
            }
            self.withResponse = true
            print(self.currentTimeMillis())
            }.resume()
        while true {
            if withResponse! {
                return (retorno)
            }
            if withTimeOut! {
                completed = .TimeOut
                return (retorno)
            }
        }
    }
    
    
    func parseJSONString(myString: String)-> AnyObject? {
        
        let data = myString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            return try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
        } else {
            return nil
        }
    }

    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        print("challenge %@", challenge.protectionSpace.authenticationMethod)
        if [NSURLAuthenticationMethodDefault, NSURLAuthenticationMethodHTTPBasic, NSURLAuthenticationMethodHTTPDigest].contains(challenge.protectionSpace.authenticationMethod) {
            if challenge.previousFailureCount > 0 {
                print("Alert Please check the credential")
                completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
            }
            else {
//                let credential = NSURLCredential(user: mySession.settings.user!, password: mySession.settings.password!, persistence: .ForSession)
                let credential = NSURLCredential(user: "hroman", password: "JavierA17", persistence: .ForSession)
            completionHandler(.UseCredential, credential)
            }
        } else {
            completionHandler(.PerformDefaultHandling, nil);
        }
    }
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
        print("URLSessionDidFinishEventsForBackgroundURLSession: \(session)")
    }

    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        print("didBecomeInvalidWithError: \(error)")
    }
    func ping()->Void{
        
    }

}
let myUtils = Utils()

//
//  urlFile.swift
//  testTutti
//
//  Created by hugo roman on 6/28/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation

class LearnNSURLSession: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate {
    typealias CallbackBlock = (result: String, error: String?) -> ()
    var callback: CallbackBlock = {
        (resultString, error) -> Void in
        if error == nil {
            println(resultString)
        } else {
            println(error)
        }
    }
    
    func httpGet(request: NSMutableURLRequest!, callback: (String,
        String?) -> Void) {
            var configuration =
            NSURLSessionConfiguration.defaultSessionConfiguration()
            var session = NSURLSession(configuration: configuration,
                delegate: self,
                delegateQueue:NSOperationQueue.mainQueue())
            var task = session.dataTaskWithRequest(request){
                (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if error != nil {
                    callback("", error.localizedDescription)
                } else {
                    var result = NSString(data: data, encoding:
                        NSASCIIStringEncoding)!
                    callback(result as String, nil)
                }
            }
            task.resume()
    }
    
    func URLSession(session: NSURLSession,
        didReceiveChallenge challenge:
        NSURLAuthenticationChallenge,
        completionHandler:
        (NSURLSessionAuthChallengeDisposition,
        NSURLCredential!) -> Void) {
            completionHandler(
                NSURLSessionAuthChallengeDisposition.UseCredential,
                NSURLCredential(forTrust:
                    challenge.protectionSpace.serverTrust))
    }
    
    func URLSession(session: NSURLSession,
        task: NSURLSessionTask,
        willPerformHTTPRedirection response:
        NSHTTPURLResponse,
        newRequest request: NSURLRequest,
        completionHandler: (NSURLRequest!) -> Void) {
            var newRequest : NSURLRequest? = request
            println(newRequest?.description);
            completionHandler(newRequest)
    }

    /*
    var learn = LearnNSURLSession()
    var request = NSMutableURLRequest(URL: NSURL(string: "http://intranet.solunegocios.com")!)
    learn.httpGet(request) {
    (resultString, error) -> Void in
    learn.callback(result: resultString, error: error)
    }
    */

    
}

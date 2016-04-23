//
//  uGoConvenience.swift
//  uGo
//
//  Created by hugo roman on 11/29/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - uGoClient (Convenient Resource Methods)

extension uGoClient {

    func uGoLogin(completionHandler:(result: ConnectionResult!, error: NSError?) -> Void)->Void {
        taskForLoginChallengeMethod() { (result, error) -> Void in
            completionHandler(result: result, error: error)
            print("resultado %@", result)
        }
    }
    
    func uGOIn(completionHandler:(result: ConnectionResult!, error: NSError?) -> Void)->Void{
        let _ = uGoClient.sharedInstance().taskForExecuteMethod(Constants.urlIn + "?" + query(setParams("I")), completionHandler: { ( complete, resultado, error) -> Void in
            let requestBodyData: NSData = resultado!.dataUsingEncoding(NSUTF8StringEncoding)!
            var logicalResult: ConnectionResult = complete
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(requestBodyData, options: .AllowFragments) as? [String: AnyObject]
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            /* GUARD: are d ok? */
            guard let dArray = parsedResult["d"] as? NSDictionary else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            
            guard let resultArray = dArray["RegistrarAsistencia"] as? [String: AnyObject] else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            guard let resultTransaction = resultArray["COD_RESULTADO"] as? String else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            if resultTransaction == "00" {
                logicalResult = .Success
            }
            
            completionHandler(result: logicalResult, error: error)
        })
    }
    
    func uGOOut(completionHandler:(result: ConnectionResult!, error: NSError?) -> Void)->Void{
        let _ = uGoClient.sharedInstance().taskForExecuteMethod(Constants.urlOut + "?" + query(setParams("S")), completionHandler: { ( complete, resultado, error) -> Void in
            let requestBodyData: NSData = resultado!.dataUsingEncoding(NSUTF8StringEncoding)!
            var logicalResult: ConnectionResult = complete
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(requestBodyData, options: .AllowFragments) as? [String: AnyObject]
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            /* GUARD: are d ok? */
            guard let dArray = parsedResult["d"] as? NSDictionary else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            
            guard let resultArray = dArray["RegistrarAsistencia"] as? [String: AnyObject] else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            guard let resultTransaction = resultArray["COD_RESULTADO"] as? String else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            if resultTransaction == "00" {
                logicalResult = .Success
            }
            completionHandler(result: logicalResult, error: error)
        })
    }
    
    
    func uGOHistoryRecord(completionHandler:(result: ConnectionResult!, error: NSError?) -> Void)->Void{
        let _ = uGoClient.sharedInstance().taskForExecuteMethod(Constants.urlHistory, completionHandler: { (complete, resultado, error) -> Void in
            var temp = [String:String]()
            let requestBodyData: NSData = resultado!.dataUsingEncoding(NSUTF8StringEncoding)!
            var parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(requestBodyData, options: .AllowFragments) as? [String: AnyObject]
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            /* GUARD: are d ok? */
            guard let dArray = parsedResult["d"] as? NSDictionary else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }

            guard let resultArray = dArray["results"] as? [[String: AnyObject]] else {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(requestBodyData)'"]
                completionHandler(result: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
                return
            }
            
            for info in resultArray {
                temp["tipo_dispositivo"] = info["tipo_dispositivo"] as? String
                if info["tipo_evento"] as? String == "S" {
                    temp["tipo_evento"] = "Salida"
                }
                else {
                    temp["tipo_evento"] = "Entrada"
                }
                let date = (info["es_registro_offline"] as? Bool == true ? info["fch_dispositivo"]:info["fch_servidor"]) as! String
                var stamp = date.componentsSeparatedByString("T")
                var hhmmss = stamp[1].componentsSeparatedByString(".")
                var hora = hhmmss[0].componentsSeparatedByString(":")
                var fecha = stamp[0].componentsSeparatedByString("-")
                temp["fch_servidor"] = "\(fecha[2])/\(fecha[1])/\(fecha[0]) - \(hora[0]):\(hora[1])"
                if let _ = info["val_latitud"] as? String {
                    temp["val_latitud"] = info["val_latitud"] as? String
                }else
                {
                    temp["val_latitud"] = ""
                }
                if let _ = info["val_longitud"] as? String {
                    temp["val_longitud"] = info["val_longitud"] as? String
                }else
                {
                    temp["val_longitud"] = ""
                }
                temp["dispositivo"] = info["tipo_dispositivo"] as? String
                let beep_id: Int! = info["BEEP_ID"] as! Int
                let xNSNumber = beep_id as NSNumber
                temp["beep_id"] = xNSNumber.stringValue
                
                let thisResult : RecordCard = RecordCard(inTipoEvento: temp["tipo_evento"]!, inFecServidor: temp["fch_servidor"]!, inValLatitud: temp["val_latitud"]!, inValLongitud: temp["val_longitud"]!, inDispositivo: temp["tipo_dispositivo"]!, inBeepId: temp["beep_id"]!)
                self.myHistoryRecords.append(thisResult)
            }
            completionHandler(result: complete, error: error)
        })
}
    
    func uGOForgetMe()->Void{
        uGoClient.sharedInstance().isConnected = false
        settings.forgetMe()
    }
    
    //for nicator
    func hoyEs()->String{
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        
        let toArray = DateInFormat.componentsSeparatedByString(" ")
        let fecha = "datetime'"+toArray.joinWithSeparator("T")+"'"
        return (fecha)
    }
    
    func setParams (lTipoEvento:String)->[String: AnyObject]{
        var params:[String:AnyObject] = ["$format":"json", "fch_dispositivo": hoyEs(), "nro_retraso_sec":0, "val_latitud":"0M", "val_longitud":"0M", "val_altura":"0", "val_precision":"0", "tipo_evento":"'" + lTipoEvento + "'", "tipo_dispositivo":"'I'", "es_mock_location": "true", "es_registro_offline": "false", "beacon_primario_major": "", "beacon_primario_minor": "", "beacon_secundario_major": "", "beacon_secundario_minor": 0]
        
        params["es_mock_location"] = "false"
        if let _ = myLocation.localPos {
            params["val_latitud"] = "\(myLocation.localPos!.coordinate.latitude)M"
            params["val_longitud"] = "\(myLocation.localPos!.coordinate.longitude)M"
            params["val_altura"] = myLocation.localPos!.altitude
            params["val_precision"] = myLocation.localPos!.horizontalAccuracy
        }
        else
        {
            params["val_latitud"] = "0M"
            params["val_longitud"] = "0M"
            params["val_altura"] = 0
            params["val_precision"] = 0
        }
        return (params)
    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy()
        legalURLCharactersToBeEscaped.addCharactersInString(":&=;+!@#()',*")
        let returnStr = string.stringByAddingPercentEncodingWithAllowedCharacters(legalURLCharactersToBeEscaped as! NSCharacterSet)
        return returnStr!
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
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        return components
    }
    
    func query(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<) {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func taskForLoginChallengeMethod(completionHandler:(complete: ConnectionResult, error: NSError?) -> Void) -> NSURLSessionDataTask {

        var thisConnResult : ConnectionResult!
        let lsUserAndPassword : String = settings.user! + ":" + settings.password!
        let userPasswordData = lsUserAndPassword.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
        let authString = "Basic  \(base64EncodedCredential) "
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = ParameterKeys.TimeOut
        config.timeoutIntervalForResource = ParameterKeys.TimeOut
        config.requestCachePolicy = .ReloadIgnoringLocalCacheData
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.currentQueue())
        
        /* 2/3. Build the URL and configure the request */
        let request = NSMutableURLRequest(URL: NSURL(string:Constants.urlLogin)!)
        request.HTTPMethod = "GET"
        
        /* 4. Make the request */

        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard (error == nil) else {
                thisConnResult = .ServerError
                completionHandler(complete: thisConnResult, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error connecting to the url"]))
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let _ = response as? NSHTTPURLResponse {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with keys"]))
                } else if let _ = response {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with server"]))
                } else {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with url response"]))
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let _ = data else {
                thisConnResult = .ServerError
                completionHandler(complete: thisConnResult, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "no data returned"]))
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            thisConnResult = .Success
            completionHandler(complete: thisConnResult, error: nil)
            // no es necesario en este caso
        }
        
        /* 7. Start the request */
        task.resume()
        return task
    }

    
    func taskForExecuteMethod(Url2Go: String, completionHandler:(complete: ConnectionResult, result:String?, error: NSError?) -> Void) -> String {
        
        let retorno :String = ""
        var thisConnResult : ConnectionResult!
        let lsUserAndPassword : String = settings.user! + ":" + settings.password!
        let userPasswordData = lsUserAndPassword.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
        let authString = "Basic  \(base64EncodedCredential) "
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = ParameterKeys.TimeOut
        config.timeoutIntervalForResource = ParameterKeys.TimeOut
        config.requestCachePolicy = .ReloadIgnoringLocalCacheData
        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.currentQueue())
        
        /* 2/3. Build the URL and configure the request */
        let request = NSMutableURLRequest(URL: NSURL(string:Url2Go)!)
        request.HTTPMethod = "GET"
        
        /* 4. Make the request */
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard (error == nil) else {
                thisConnResult = .ServerError
                completionHandler(complete: thisConnResult,result: nil, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error connecting to the url"]))
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                if let _ = response as? NSHTTPURLResponse {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, result: nil, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with keys"]))
                } else if let _ = response {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, result: nil, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with server"]))
                } else {
                    thisConnResult = .ServerError
                    completionHandler(complete: thisConnResult, result: nil, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error with url response"]))
                }
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let _ = data else {
                thisConnResult = .ServerError
                completionHandler(complete: thisConnResult, result: nil, error: NSError(domain: "taskForGETMethod", code: 0, userInfo: [NSLocalizedDescriptionKey: "no data returned"]))
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)?.description
            thisConnResult = .Success
            completionHandler(complete: thisConnResult, result: dataString , error: nil)
            
        }
        
        /* 7. Start the request */
        task.resume()
        return retorno
    }
    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        print("challenge %@", challenge.protectionSpace.authenticationMethod)
        if [NSURLAuthenticationMethodDefault, NSURLAuthenticationMethodHTTPBasic, NSURLAuthenticationMethodHTTPDigest].contains(challenge.protectionSpace.authenticationMethod) {
            if challenge.previousFailureCount > 0 {
                completionHandler(NSURLSessionAuthChallengeDisposition.CancelAuthenticationChallenge, nil)
            }
            else {
                let credential = NSURLCredential(user: settings.user!, password: settings.password!, persistence: .ForSession)
                completionHandler(.UseCredential, credential)
            }
        } else {
            completionHandler(.CancelAuthenticationChallenge, nil);
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
    

}

//
//  Session.swift
//  testTutti
//
//  Created by hugo roman on 7/4/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation

class Session {

    //for url only
    let urlLogin :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc"
    let urlIn :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
    let urlOut:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
    let urlHistory:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/LeerAsistenciaUltimosDias?$format=json"
    
    private let keychain = Keychain(service: "com.solu4b.uGO!", accessibility: .Always)
    var settings = PersistedSettings.sharedInstance

    init() {
        settings = PersistedSettings()
    }
    
    func ping()->Void{
        
    }
    
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
    
    func setParams (lTipoEvento:String)->[String: AnyObject]{
        var params:[String:AnyObject] = ["fch_dispositivo": hoyEs(), "nro_retraso_sec":0, "val_latitud":"0M", "val_longitud":"0M", "val_altura":"0", "val_precision":"0", "tipo_evento":"'" + lTipoEvento + "'", "tipo_dispositivo":"'I'", "es_mock_location": "true", "es_registro_offline": "false", "beacon_primario_major": "", "beacon_primario_minor": "", "beacon_secundario_major": "", "beacon_secundario_minor": 0]
        
        params["es_mock_location"] = "false"
        params["val_latitud"] = "\(myLocation.localPos.coordinate.latitude)M"
        params["val_longitud"] = "\(myLocation.localPos.coordinate.longitude)M"
        params["val_altura"] = myLocation.localPos.altitude
        params["val_precision"] = myLocation.localPos.horizontalAccuracy
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
    
    func uGOLogin(inout ret:ConnectionResult)->String{
        var dataOut:String = ""
        dataOut = Utils.connectToSvc(urlLogin, lsUserAndPassword: (settings.userAndPassword!), completed: &ret)
        return (dataOut)
    }
    
    func uGOIn(inout ret:ConnectionResult)->String{
        var dataOut:String = ""
        dataOut = Utils.connectToSvc(urlIn + "?" + query(setParams("I")), lsUserAndPassword: (settings.userAndPassword!), completed: &ret)
        return (dataOut)
    }
    
    func uGOOut(inout ret:ConnectionResult)->String{
        var dataOut:String = ""
        dataOut = Utils.connectToSvc(urlOut + "?" + query(setParams("S")), lsUserAndPassword: (settings.userAndPassword!), completed: &ret)
        return (dataOut)
    }
    
    func uGOHistory(inout ret:ConnectionResult)->String{
        var dataOut:String = ""
        dataOut = Utils.connectToSvc(urlHistory, lsUserAndPassword: (settings.userAndPassword!), completed: &ret)
        return (dataOut)
    }
    
    
}

let mySession = Session()


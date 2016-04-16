//
//  uGoConstant.swift
//  uGo
//
//  Created by hugo roman on 12/13/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//
extension uGoClient {
    
    // MARK: Constants
    struct Constants {
        // MARK: URLs
        //for url only
        static let urlLogin :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc"
        static let urlIn :String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
        static let urlOut:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/RegistrarAsistencia"
        static let urlHistory:String = "http://apps.solu4b.com/beepinservice/BeepInDataService.svc/LeerAsistenciaUltimosDias?$format=json"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let TimeOut = 10.0

        static let Query = "query"
        static let AppJSon = "application/json"
        static let ContentTypeJSon = "Content-Type"
    }
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        // MARK: General
        static let Stat = "stat"
        static let TotalPages = "pages"
    }
}
//
//  RecordCard.swift
//  testTutti
//
//  Created by hugo roman on 10/23/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//
import Foundation

class RecordCard {
    var rcTipoEvento = ""
    var rcEsRegistroOffline = ""
    var rcFecServidor = ""
    var rcValLatitud = ""
    var rcValLongitud = ""
    var rcDispositivo = ""
    var rcBeepId = ""
    
    init(inTipoEvento: String, inEsRegistroOffline: String, inFecServidor: String, inValLatitud: String, inValLongitud: String, inDispositivo: String, inBeepId: String ){
        rcTipoEvento = inTipoEvento
        rcEsRegistroOffline = inEsRegistroOffline
        rcFecServidor = inFecServidor
        rcValLatitud = inValLatitud
        rcValLongitud = inValLongitud
        rcDispositivo = inDispositivo
        rcBeepId = inBeepId
    }
    
}
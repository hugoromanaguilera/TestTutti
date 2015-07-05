//
//  Session.swift
//  testTutti
//
//  Created by hugo roman on 7/4/15.
//  Copyright (c) 2015 hugo roman. All rights reserved.
//

import Foundation


class Session {

    private let keychain = Keychain(service: "com.solu4b.uGO!", accessibility: .Always)
    var settings = PersistedSettings.sharedInstance
    var userAndPassword : String = ""

    init() {
        settings = PersistedSettings()
    }
}

let mySession = Session()


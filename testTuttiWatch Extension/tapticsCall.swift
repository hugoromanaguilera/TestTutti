//
//  tapticsCall.swift
//  testTutti
//
//  Created by hugo roman on 2/27/16.
//  Copyright © 2016 hugo roman. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class tapticsCall: NSObject {
    
    struct Taptics {
        var hapticTypes = [
            "Notification": WKHapticType.Notification,
            "DirectionUp": WKHapticType.DirectionUp,
            "DirectionDown": WKHapticType.DirectionDown,
            "Success": WKHapticType.Success,
            "Failure": WKHapticType.Failure,
            "Retry": WKHapticType.Retry,
            "Start": WKHapticType.Start,
            "Stop": WKHapticType.Stop,
            "Click": WKHapticType.Click,
        ]
    }

    func giveNotification()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Notification)
    }

    func giveDirectionUp()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.DirectionUp)
    }
    
    func giveDirectionDown()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.DirectionDown)
    }
    
    func giveSuccess()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Success)
    }
    
    func giveFailure()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Failure)
    }
    
    func giveRetry()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Retry)
    }
    
    func giveSart()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Start)
    }
    
    func giveStop()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Stop)
    }
    
    func giveClick()->Void{
        WKInterfaceDevice.currentDevice().playHaptic(WKHapticType.Click)
    }
}

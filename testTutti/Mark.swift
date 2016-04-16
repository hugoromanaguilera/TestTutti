//
//  Pin.swift
//  VirtualTourist
//
//  Created by hugo roman on 12/20/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import CoreData

class Mark : NSManagedObject {
    
    struct Keys {
        static let markId = "markId"
    }
    
    @NSManaged var markId: String
    @NSManaged var inOrOut: String
    @NSManaged var device: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var timeStamp: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity =  NSEntityDescription.entityForName("Mark", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        markId = dictionary["markId"] as! String
        inOrOut = dictionary["inOrOut"] as! String
        device = dictionary["device"] as! String
        longitude = dictionary["longitude"] as! Double
        latitude = dictionary["latitude"] as! Double
        timeStamp = dictionary["longitude"] as! String
    }

}



//
//  Person.swift
//  uGo
//
//  Created by hugo roman on 12/15/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import CoreData
import UIKit

class Person : NSManagedObject {
    
    struct Keys {
        static let userEmail = "userEmail"
    }
    
    @NSManaged var userEmail: String
    @NSManaged var userPassword: String
    @NSManaged var lastDateMarkIn: String
    @NSManaged var lastDateMarkOut: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        userEmail = (dictionary["userEmail"] ?? " ") as! String
        userPassword = (dictionary["userPassword"] ?? " ") as! String
        lastDateMarkIn = (dictionary["lastDateMarkIn"] ?? " ") as! String
        lastDateMarkOut = (dictionary["lastDateMarkOut"] ?? " ") as! String
    }
    
    
    override func prepareForDeletion(){
    }
}




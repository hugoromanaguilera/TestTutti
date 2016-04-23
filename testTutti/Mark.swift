//
//
//  Created by hugo roman on 12/20/15.
//  Copyright © 2015 hugo roman. All rights reserved.
//

import CoreData

class Mark : NSManagedObject {

    struct Keys {
        static let rcBeepId = "BeepId"
    }
    
    @NSManaged var rcDispositivo: String
    @NSManaged var rcFecServidor: String
    @NSManaged var rcTipoEvento: String
    @NSManaged var rcValLatitud: String
    @NSManaged var rcValLongitud: String
    @NSManaged var rcBeepId: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity =  NSEntityDescription.entityForName("Mark", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        rcDispositivo = dictionary["rcDispositivo"] as! String
        rcFecServidor = dictionary["rcFecServidor"] as! String
        rcTipoEvento = dictionary["rcTipoEvento"] as! String
        rcValLatitud = dictionary["rcValLatitud"] as! String
        rcValLongitud = dictionary["rcValLongitud"] as! String
        rcBeepId = dictionary["rcBeepId"] as! String
    }
    
}



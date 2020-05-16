//
//  Trip+CoreDataProperties.swift
//  
//
//  Created by Naomi Schettini on 5/15/20.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var id: String?
    @NSManaged public var progress: String?
    @NSManaged public var truckingOrder: TruckingOrder?

}

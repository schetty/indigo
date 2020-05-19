//
//  Load+CoreDataProperties.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData


extension Load {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Load> {
        return NSFetchRequest<Load>(entityName: "Load")
    }

    @NSManaged public var trips: Set<Trip>

}

// MARK: Generated accessors for trips
extension Load {

    @objc(addTripsObject:)
    @NSManaged public func addToTrips(_ value: Trip)

    @objc(removeTripsObject:)
    @NSManaged public func removeFromTrips(_ value: Trip)

    @objc(addTrips:)
    @NSManaged public func addToTrips(_ values: NSSet)

    @objc(removeTrips:)
    @NSManaged public func removeFromTrips(_ values: NSSet)

}

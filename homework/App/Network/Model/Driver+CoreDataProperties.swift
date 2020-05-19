//
//  Driver+CoreDataProperties.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData


extension Driver {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Driver> {
        return NSFetchRequest<Driver>(entityName: "Driver")
    }

    @NSManaged public var token: String?
    @NSManaged public var loads: Load?

}

// MARK: Generated accessors for loads
extension Driver {

    @objc(addLoadsObject:)
    @NSManaged public func addToLoads(_ value: Load)

    @objc(removeLoadsObject:)
    @NSManaged public func removeFromLoads(_ value: Load)

    @objc(addLoads:)
    @NSManaged public func addToLoads(_ values: NSSet)

    @objc(removeLoads:)
    @NSManaged public func removeFromLoads(_ values: NSSet)

}

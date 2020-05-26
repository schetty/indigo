//
//  LoadModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension LoadModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoadModel> {
        return NSFetchRequest<LoadModel>(entityName: "LoadModel")
    }

    @NSManaged public var ofDriverModel: DriverModel?
    @NSManaged public var trips: Set<TripModel>?

}

// MARK: Generated accessors for trips
extension LoadModel {

    @objc(addTripsObject:)
    @NSManaged public func addToTrips(_ value: TripModel)

    @objc(removeTripsObject:)
    @NSManaged public func removeFromTrips(_ value: TripModel)

    @objc(addTrips:)
    @NSManaged public func addToTrips(_ values: NSSet)

    @objc(removeTrips:)
    @NSManaged public func removeFromTrips(_ values: NSSet)

}

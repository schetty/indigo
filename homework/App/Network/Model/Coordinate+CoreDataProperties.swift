//
//  Coordinate+CoreDataProperties.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

extension Coordinate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coordinate> {
        return NSFetchRequest<Coordinate>(entityName: "Coordinate")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

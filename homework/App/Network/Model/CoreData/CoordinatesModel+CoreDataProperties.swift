//
//  CoordinatesModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension CoordinatesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordinatesModel> {
        return NSFetchRequest<CoordinatesModel>(entityName: "CoordinatesModel")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var ofLocation: LocationModel?

}

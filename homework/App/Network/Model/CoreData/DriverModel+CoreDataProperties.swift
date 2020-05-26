//
//  DriverModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension DriverModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DriverModel> {
        return NSFetchRequest<DriverModel>(entityName: "DriverModel")
    }

    @NSManaged public var loads: LoadModel?
    @NSManaged public var ofDataModel: DataModel?

}

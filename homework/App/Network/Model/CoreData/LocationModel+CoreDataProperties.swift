//
//  LocationModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationModel> {
        return NSFetchRequest<LocationModel>(entityName: "LocationModel")
    }

    @NSManaged public var loadingInstructions: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: AddressModel?
    @NSManaged public var coordinates: CoordinatesModel?
    @NSManaged public var ofTruckingOrderModelFrom: TruckingOrderModel?
    @NSManaged public var ofTruckingOrderModelTo: TruckingOrderModel?

}

//
//  TruckingOrderModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension TruckingOrderModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TruckingOrderModel> {
        return NSFetchRequest<TruckingOrderModel>(entityName: "TruckingOrderModel")
    }

    @NSManaged public var orderType: String?
    @NSManaged public var tripDistanceMiles: Int16
    @NSManaged public var locationFrom: LocationModel?
    @NSManaged public var locationTo: LocationModel?
    @NSManaged public var ofTripModel: TripModel?

}

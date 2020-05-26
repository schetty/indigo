//
//  TripModel+CoreDataProperties.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData


extension TripModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripModel> {
        return NSFetchRequest<TripModel>(entityName: "TripModel")
    }

    @NSManaged public var deliveryStatus: String?
    @NSManaged public var progress: String?
    @NSManaged public var scheduledDeliveryOn: String?
    @NSManaged public var truckingOrder: TruckingOrderModel?
    @NSManaged public var ofLoadModel: LoadModel?

}

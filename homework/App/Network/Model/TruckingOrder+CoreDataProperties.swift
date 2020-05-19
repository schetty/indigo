//
//  TruckingOrder+CoreDataProperties.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

extension TruckingOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TruckingOrder> {
        return NSFetchRequest<TruckingOrder>(entityName: "TruckingOrder")
    }

    @NSManaged public var id: String?
    @NSManaged public var orderType: String?
    @NSManaged public var tripDistanceMiles: Int32
    @NSManaged public var locationFrom: Coordinate?
    @NSManaged public var locationTo: Coordinate?

}

//
//  TripModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TripModel)
public class TripModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case deliveryStatus, progress, scheduledDeliveryOn, truckingOrder
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let contextKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "TripModel", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deliveryStatus = try container.decode(String.self, forKey: .deliveryStatus)
        self.progress = try container.decode(String.self, forKey: .progress)
        self.scheduledDeliveryOn = try container.decode(String.self, forKey: .scheduledDeliveryOn)
        self.truckingOrder = try container.decode(TruckingOrderModel.self, forKey: .truckingOrder)
    }
}

//
//  TruckingOrderModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TruckingOrderModel)
public class TruckingOrderModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case tripDistanceMiles, orderType, locationFrom, locationTo
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "TruckingOrderModel", in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tripDistanceMiles = try container.decode(Int16.self, forKey: .tripDistanceMiles)
        self.orderType = try container.decode(String.self, forKey: .orderType)
        self.locationFrom = try container.decode(LocationModel.self, forKey: .locationFrom)
        self.locationTo = try container.decode(LocationModel.self, forKey: .locationTo)
    }
}

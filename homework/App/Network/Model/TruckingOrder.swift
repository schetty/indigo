//
//  TruckingOrder+CoreDataClass.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

public class TruckingOrder: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case orderType
        case tripDistanceMiles
        case locationFrom
        case locationTo
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Some fatal error") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Driver", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try values.decode(String.self, forKey: .id)
            self.orderType = try values.decode(String.self, forKey: .orderType)
            self.tripDistanceMiles = try values.decode(Int32.self, forKey: .tripDistanceMiles)
            self.locationFrom = try values.decode(Coordinate.self, forKey: .locationFrom)
            self.locationTo = try values.decode(Coordinate.self, forKey: .locationTo)
        } catch {
            print ("Cannot parse Driver")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id ?? "no id", forKey: .id)
            try container.encode(orderType ?? "no order type", forKey: .orderType)
            try container.encode(tripDistanceMiles, forKey: .tripDistanceMiles)
            try container.encode(locationFrom, forKey: .locationFrom)
            try container.encode(locationTo, forKey: .locationTo)
        } catch {
            print("error")
        }
    }
}

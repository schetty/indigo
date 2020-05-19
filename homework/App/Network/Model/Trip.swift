//
//  Trip+CoreDataClass.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

public class Trip: NSManagedObject, Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case progress
        case truckingOrder
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Some fatal error") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Trip", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try values.decode(String.self, forKey: .id)
            self.progress = try values.decode(String.self, forKey: .progress)
            self.truckingOrder = try values.decode(TruckingOrder.self, forKey: .truckingOrder)
        } catch {
            print ("Cannot parse Driver")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id ?? "no id", forKey: .id)
            try container.encode(progress ?? "no progress", forKey: .progress)
        } catch {
            print("error")
        }
    }
}


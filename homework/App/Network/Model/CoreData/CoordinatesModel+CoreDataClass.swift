//
//  CoordinatesModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CoordinatesModel)
public class CoordinatesModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let contextKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError()
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "CoordinatesModel", in: context) else {
            fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}

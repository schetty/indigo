//
//  LoadModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LoadModel)
public class LoadModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case trips
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let contextKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "LoadModel", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trips = try container.decode(Set<TripModel>.self, forKey: .trips)
    }
}

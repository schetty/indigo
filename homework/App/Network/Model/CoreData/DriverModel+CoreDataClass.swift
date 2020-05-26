//
//  DriverModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DriverModel)
public class DriverModel: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case loads
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let contextKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DriverModel", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.loads = try container.decode(LoadModel.self, forKey: .loads)
    }
}

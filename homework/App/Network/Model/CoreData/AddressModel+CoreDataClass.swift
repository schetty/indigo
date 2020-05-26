//
//  AddressModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AddressModel)
public class AddressModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case street, city, postalCode, state, country
    }
    
    required convenience public init(from decoder: Decoder) throws {
        let contextKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "AddressModel", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.postalCode = try container.decode(String.self, forKey: .postalCode)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
    }
}

//
//  LocationModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(LocationModel)
public class LocationModel: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case phone, address, name, coordinates, loadingInstructions
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context,
            let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "LocationModel", in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.address = try container.decode(AddressModel.self, forKey: .address)
        self.name = try container.decode(String.self, forKey: .name)
        self.coordinates = try container.decode(CoordinatesModel.self, forKey: .coordinates)
        self.loadingInstructions = try container.decode(String.self, forKey: .loadingInstructions)
    }
}

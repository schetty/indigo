//
//  ResponseModel+CoreDataClass.swift
//  homework
//
//  Created by Naomi Schettini on 5/20/20.
//  Copyright © 2020 Indigo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ResponseModel)
public class ResponseModel: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
        case data
    }

    required convenience public init(from decoder: Decoder) throws {
        let contextUserInfoKey = CodingUserInfoKey.context
        guard let context = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: "ResponseModel", in: context) else {
            fatalError("Failed to decode")
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(DataModel.self, forKey: .data)
    }
}

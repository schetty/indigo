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
        guard let contextKey = CodingUserInfoKey.context,
            let context = decoder.userInfo[contextKey] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "ResponseModel", in: context) else { fatalError() }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(DataModel.self, forKey: .data)
    }
}

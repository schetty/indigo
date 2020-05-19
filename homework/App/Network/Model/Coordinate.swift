//
//  Coordinate+CoreDataClass.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

public class Coordinate: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context
          let context = CoreDataHelper.sharedInstance.persistentContainer.viewContext
          guard let entity = NSEntityDescription.entity(forEntityName: "Coordinate", in: context) else {
              fatalError()
          }
        
        self.init(entity: entity, insertInto: context)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

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
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Some fatal error") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Coordinate", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try values.decode(Double.self, forKey: CodingKeys.latitude)
        self.longitude = try values.decode(Double.self, forKey: CodingKeys.longitude)
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

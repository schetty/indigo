//
//  Load+CoreDataClass.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData


public class Load: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case trips
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else { fatalError("Some fatal error") }
        guard let entity = NSEntityDescription.entity(forEntityName: "Trip", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.trips = try values.decode(Set<Trip>.self, forKey: .trips)
            
        } catch {
            print ("Cannot parse Loads")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
    
}

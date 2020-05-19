//
//  Driver+CoreDataClass.swift
//  
//
//  Created by Naomi Schettini on 5/17/20.
//
//

import Foundation
import CoreData

public class Driver: NSManagedObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case token
        case loads
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context, let context = CoreDataHelper.sharedInstance.persistentContainer.viewContext, let entity = NSEntityDescription.entity(forEntityName: "Driver", in: context) else {
            fatalError()
        }
        
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.token = try values.decode(String.self, forKey: .token)
            self.loads = try values.decode(Set<Load>.self, forKey: .loads)
        } catch {
            print ("Cannot parse Driver")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(token ?? "no token", forKey: .token)
        } catch {
            print("error")
        }
    }
}

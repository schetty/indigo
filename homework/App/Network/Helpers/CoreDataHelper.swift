//
//  CoreDataHelper.swift
//  homework
//
//  Created by Naomi Schettini on 5/18/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static let sharedInstance: CoreDataHelper = CoreDataHelper()
    
    var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        
        let container = NSPersistentContainer(name: "DriverData")
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
   class func arrayOf<T: NSManagedObject>(_ entity: T.Type,
                                           predicate: NSPredicate? = nil,
                                           sortDescriptor: [NSSortDescriptor]? = nil,
                                           context: NSManagedObjectContext = CoreDataHelper.sharedInstance.getContext()) -> NSMutableArray? {

        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))

        if predicate != nil {
            fetchRequest.predicate = predicate!
        }

        if sortDescriptor != nil {
            fetchRequest.sortDescriptors = sortDescriptor!
        }

        fetchRequest.returnsObjectsAsFaults = false

        do {

            let searchResult = try context.fetch(fetchRequest)
            if searchResult.count > 0 {
                // returns mutable copy of result array
                return NSMutableArray.init(array: searchResult)
            } else {
                // returns nil in case no object found
                return nil
            }

        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}


extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}

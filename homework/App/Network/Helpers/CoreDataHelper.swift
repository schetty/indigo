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
    
    func getItems<T : NSManagedObject>(predicate : NSPredicate? = nil) -> [T]{
        do {
            let reqest = T.fetchRequest()
            reqest.predicate = predicate
            if let items = try persistentContainer.viewContext.fetch(reqest) as? [T] {
                return items
            } else {
                return [T]()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [T]()
        }
    }
    
    func getObjectBy<T : NSManagedObject>(id : NSManagedObjectID) -> T? {
        if let object = try? persistentContainer.viewContext.existingObject(with: id) as? T {
            return object
        }
        else {
            return nil
        }
    }
    
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
    
    func saveContext () {
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
    
}

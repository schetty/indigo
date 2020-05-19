//
//  PersistencyManager.swift
//  homework
//
//  Created by Naomi Schettini on 5/15/20.
//  Copyright © 2020 Indigo. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class PersistencyManager {
    
    static let sharedManager = PersistencyManager()
    
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DriverData")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = PersistencyManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

/* DATA MANAGEMENT */
extension PersistencyManager {
    
    func buildDriver(token: String) {

        let managedContext = PersistencyManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Driver",
                                                in: managedContext)!
  
        let driver = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        driver.setValue(token, forKeyPath: "token")

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchDriver() -> Driver? {
      
      let managedContext = PersistencyManager.sharedManager.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Driver")
      do {
        let driver = try managedContext.fetch(fetchRequest)
        return driver.first as? Driver
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return nil
      }
    }
}

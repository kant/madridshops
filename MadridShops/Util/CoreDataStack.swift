//
//  CoreDataStack.swift
//  CoreDataHelloWorld
//
//  Created by Bamby on 15/11/17.
//  Copyright © 2017 Juan S. Landy. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStack{
    // MARK: - Core Data stack
    
    public func createContainer(dataBaseName: String) -> NSPersistentContainer{
        let container = NSPersistentContainer(name: dataBaseName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            print("💾 \(storeDescription)")
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    // MARK: - Core Data Saving support
    public func saveContext (context: NSManagedObjectContext) {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

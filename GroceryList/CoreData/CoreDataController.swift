//
//  CoreDataController.swift
//  GroceryList
//
//  Created by Rob Daly on 10/12/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataController {
    
    static let sharedInstance = CoreDataController()
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GroceryList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Could not save context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteGroceryManagedObjects() {
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        var groceries = [Grocery]()
        do {
            groceries = try self.context.fetch(request)
            groceries.forEach { context.delete($0) }
            self.saveContext()
        } catch {
            let nserror = error as NSError
            print("Could not fetch todos: \(nserror), \(nserror.userInfo)")
        }
    }
    
    // TODO: lowercase groceries when entering into core data then search with lowercased words
    func fetchGrocery(from listItem: String) -> [Grocery]? {
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        let predicate = NSPredicate(format: "name = '%@'", listItem)
        request.predicate = predicate
        
        var groceries: [Grocery]?
        do {
            groceries = try self.context.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Could not fetch todos: \(nserror), \(nserror.userInfo)")
        }
        return groceries
    }
    
    func fetchSimilarGrocery(from listItem: String) -> [Grocery]? {
        let request: NSFetchRequest<Grocery> = Grocery.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", listItem)
        request.predicate = predicate
        
        var groceries: [Grocery]?
        do {
            groceries = try self.context.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Could not fetch todos: \(nserror), \(nserror.userInfo)")
        }
        return groceries
    }
}

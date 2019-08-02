//
//  CoreManager.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

let core = CoreManager.shared

final class CoreManager {
    
    static let shared = CoreManager()
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: Constants.Keys.GoogleBooks.rawValue)
        
        container.loadPersistentStores(completionHandler: { (persistentStore, err) in
            if let error = err {
                fatalError("Could Not Load Store")
            }
        })
        
        return container
        
    }()
    
    //MARK: Load
    
    func load() -> [CoreBook]? {
        
        let fetchRequest = NSFetchRequest<CoreBook>(entityName: Constants.Core.CoreBook.rawValue)
        
        //container
        var coreBooks = [CoreBook]()
        
        do {
            coreBooks = try context.fetch(fetchRequest)
            return coreBooks
        } catch {
            return nil
        }
    }
    
    
    //MARK: Save
    
    func save(_ book: Book) {
        
        let entity = NSEntityDescription.entity(forEntityName: Constants.Core.CoreBook.rawValue, in: context)!
        
        let coreBook = NSManagedObject(entity: entity, insertInto: context)
        
        coreBook.setValue(book.volumeInfo.title, forKey: Constants.Core.title.rawValue)
        coreBook.setValue(book.id, forKey: Constants.Core.uid.rawValue)
        coreBook.setValue(book.volumeInfo.author?.joined(separator: ", "), forKey: Constants.Core.author.rawValue)
        coreBook.setValue(book.volumeInfo.description, forKey: Constants.Core.descrip.rawValue)
        coreBook.setValue(book.volumeInfo.images.thumbnail, forKey: Constants.Core.url.rawValue)
        
        saveContext()
        
        print("Saved Book: \(book.volumeInfo.title)")
        
        
    }
    
    //MARK: Delete
    
    func delete(_ core: CoreBook) {
        
        context.delete(core)
        print("Deleted Book: \(core.title!), \(core.author!)")
        saveContext()
        
    }
    
    //call this in the detail page to determine whether or not to show button
    //NSPredicate to search if UID matches any of core items and return boolean
    func isFavorite(_ id: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<CoreBook>(entityName: Constants.Core.CoreBook.rawValue)
        
        let predicate = NSPredicate(format: "uid == %@", id)
        
        fetchRequest.predicate = predicate
        
        var book: CoreBook!
        
        do {
            book = try context.fetch(fetchRequest).first
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        
        
        return book != nil
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Context Can't Be Saved")
            }
        }
    }
}

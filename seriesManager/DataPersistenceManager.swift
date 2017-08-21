//
//  DataPersistenceManager.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{
    
    
    func getManagedContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(episodeId: String) {
        guard let managedContext = getManagedContext() else {
            return
        }
        let entity = NSEntityDescription.entity(forEntityName: EpisodeModel.DataPersistenceKeys.episodeModelName, in: managedContext)!
        let ep = NSManagedObject(entity: entity, insertInto: managedContext)
        ep.setValue(episodeId, forKey: EpisodeModel.DataPersistenceKeys.idKey)
        save(managedContext: managedContext)
    }
    
    func delete(episodeId: String) {
        delete(entityName: EpisodeModel.DataPersistenceKeys.episodeModelName, filter: EpisodeModel.DataPersistenceKeys.idKey, value: episodeId)
    }
    
    func getEpisodes() -> [String] {
        var result = [String]()
        let foundObjects = fetchWith(entityName: EpisodeModel.DataPersistenceKeys.episodeModelName)
        
        for object in foundObjects {
            if let resultString = object.value(forKey: EpisodeModel.DataPersistenceKeys.idKey) as? String {
                result.append(resultString)
            }
        }
        return result
    }
    
    
    func save(managedContext: NSManagedObjectContext) {
        do{
            try managedContext.save()
        }catch let error as NSError {
            NSLog("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete(entityName: String, filter: String, value: Any) {
        
        guard let managedContext = getManagedContext() else {
            return
        }
       
        let foundObjects = fetchWith(entityName: entityName, filter: filter, value: value)
        for object in foundObjects {
            managedContext.delete(object)
        }
        save(managedContext: managedContext)
    }

    func fetchWith(entityName: String) -> [NSManagedObject] {
        return fetchWith(entityName: entityName, filter: nil, value: nil)
    }
    func fetchWith(entityName: String, filter: String?, value: Any?) -> [NSManagedObject] {
        var result = [NSManagedObject]()
        guard let managedContext = getManagedContext() else {
            return result
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        if let filter = filter, let value = value {
            fetchRequest.predicate = NSPredicate(format: "\(filter) = %@", "\(value)")
        }
        
        do {
            result = try managedContext.fetch(fetchRequest) as [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return result
    }


    
}

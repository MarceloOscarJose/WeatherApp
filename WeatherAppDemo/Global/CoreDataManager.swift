//
//  CoreDataManager.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 21/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import CoreData

class CoreDataManager: NSObject {

    static let sharedInstance = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherAppDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
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
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

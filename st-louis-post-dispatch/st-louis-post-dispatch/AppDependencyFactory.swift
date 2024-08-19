//
//  AppDependencyFactory.swift
//  st-louis-post-dispatch
//
//  Created by Fernando Campo Garcia on 18/08/24.
//

import Foundation
import CoreData
import UIKit

struct AppDependencyFactory {
    let persistenceManager: PersistenceManager
    let httpClient: HttpClient
    
    init() {
        self.persistenceManager = PersistenceManager()
        self.httpClient = MockHttpClient() // In production needs to substitute with URLSession
    }
    
    var context: NSManagedObjectContext {
        persistenceManager.container.viewContext
    }
    
    func saveContext () {
        let context = persistenceManager.container.viewContext
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
    
    func makeMainModule() -> ViewModel {
        return ViewModel(context: context, httpClient: httpClient)
    }
}

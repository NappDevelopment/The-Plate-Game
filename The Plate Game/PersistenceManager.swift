//
//  PersistenceManager.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    let context: NSManagedObjectContext
    
    init(withContext context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            fatalError("Error saving context")
        }
    }
    
    func getStates() -> [State] {
        let fetchRequest: NSFetchRequest<State> = State.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let states = try context.fetch(fetchRequest)
            
            return states
        } catch {
            fatalError("Error executive fetch request")
        }
    }
}

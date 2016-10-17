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
    private let stateDataFile = (name: "StateData", type: "json")
    private let context: NSManagedObjectContext
    
    init(withContext context: NSManagedObjectContext) {
        self.context = context
        
        guard let path = Bundle.main.path(forResource: stateDataFile.name, ofType: stateDataFile.type) else {
            fatalError("Invalid Filename or Path: \(stateDataFile)")
        }
        
        if let json = getJSON(fromPath: path), let jsonVersion = getJSONVersion(json: json) {
            let storedJSONVersion = UserDefaults.standard.integer(forKey: "jsonVersion")
            
            if storedJSONVersion == 0 {
                importJSONData(context: context, fromJSON: json)
                UserDefaults.standard.set(jsonVersion, forKey: "jsonVersion")
            } else if storedJSONVersion != jsonVersion {
                fatalError("Must write this to import new data")
            }
        }
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
    
    func getJSONVersion(json: JSON) -> Int? {
        return json["version"].int
    }
    
    func importJSONData(context: NSManagedObjectContext, fromJSON json: JSON) {
        for (_, value) in json["states"] {
            if let stateName = value.first?.0, let stateData = value.first?.1 {
                let newState = State(context: context)
                
                newState.name = stateName
                newState.capital = stateData["capital"].string!
                newState.abbreviation = stateData["abbreviation"].string!
                newState.largestCity = stateData["largestCity"].string!
                newState.residentNickname = stateData["residentNickname"].string!
                newState.nickname = stateData["nickname"].string!
                
                newState.year = (stateData["year"].int16)!
                newState.area = (stateData["area"].int32)!
                newState.elevation = (stateData["elevation"].int32)!
                newState.population = (stateData["population"].int64)!
                
                newState.isFound = false
            }
        }
        
        // Save the context.
       self.save()
    }
    
    func getJSON(fromPath path: String) -> JSON? {
        do {
            let data = try NSData(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe)
            let jsonObj = JSON(data: data as Data)
            guard jsonObj != JSON.null else {
                print("Could not get json from file, make sure that file contains valid json.")
                return nil
            }
            
            return jsonObj
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

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
    private let provinceDataFile = (name: "ProvinceData", type: "json")
    private let context: NSManagedObjectContext
    
    init(withContext context: NSManagedObjectContext) {
        self.context = context
        
        guard let path = Bundle.main.path(forResource: provinceDataFile.name, ofType: provinceDataFile.type) else {
            fatalError("Invalid Filename or Path: \(provinceDataFile)")
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
    
    func getRegions() -> [[Province]] {
        let fetchRequest: NSFetchRequest<Province> = Province.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let provinces = try context.fetch(fetchRequest)
            let regions = [
                provinces.filter({$0.region == region.us.rawValue}),
                provinces.filter({$0.region == region.canada.rawValue})
            ]
            
            return regions
        } catch {
            fatalError("Error executive fetch request")
        }
    }
    
    func getJSONVersion(json: JSON) -> Int? {
        return json["version"].int
    }
    
    func importJSONData(context: NSManagedObjectContext, fromJSON json: JSON) {
        for (_, regions) in json["regions"] {
            for (region, provinceData) in regions {
                for (province, provinceData) in provinceData {
                    let newProvince = Province(context: context)
                    
                    newProvince.region = region
                    newProvince.name = province
                    newProvince.capital = provinceData["capital"].string!
                    newProvince.abbreviation = provinceData["abbreviation"].string!
                    newProvince.largestCity = provinceData["largestCity"].string!
                    newProvince.residentNickname = provinceData["residentNickname"].string!
                    newProvince.nickname = provinceData["nickname"].string!
                    
                    newProvince.year = (provinceData["year"].int16)!
                    newProvince.area = (provinceData["area"].int32)!
                    newProvince.elevation = (provinceData["elevation"].int32)!
                    newProvince.population = (provinceData["population"].int64)!
                    
                    newProvince.isFound = false
                }
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

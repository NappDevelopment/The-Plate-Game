//
//  RegionManager.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import Foundation

protocol RegionManagerDelegate {
    func regionManager(_ regionManager: RegionManager, didUpdateFoundProvinceCount count: Int)
}

enum region: String {
    case us = "United States"
    case canada = "Canada"
    
    static func forSection(_ index: Int) -> region {
        switch index {
        case 0:
            return .us
        case 1:
            return .canada
        default:
            fatalError("Invalid index for region")
        }
    }
}

final class RegionManager {

    private var persistenceManager: PersistenceManager
    private(set) var regions: [[Province]]
    
    var provincesRemaining: Int {
        var count = 0
        for region in regions {
            count += region.filter({!$0.isFound}).count
        }
        return count
    }
    
    var delegate: RegionManagerDelegate?
    
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        self.regions = persistenceManager.getRegions()
    }
    
    func markProvince(at indexPath: IndexPath, asFound isFound: Bool) {
        regions[indexPath.section][indexPath.row].isFound = isFound
        persistenceManager.save()
        
        delegate?.regionManager(self, didUpdateFoundProvinceCount: provincesRemaining)
    }
    
}

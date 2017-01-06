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

final class RegionManager {

    private var persistenceManager: PersistenceManager
    private(set) var unfilteredRegions: [region:[Province]]
    private(set) var filteredRegions: [region:[Province]]
    
    var searchQuery: String? {
        didSet {
            if let query = searchQuery {
                filteredRegions = filter(regions: unfilteredRegions, query: query)
            } else {
                filteredRegions = unfilteredRegions
            }
        }
    }
    
    var provincesRemaining: Int {
        return unfilteredRegions.reduce(0) { sum, tuple in
            sum + tuple.value.reduce(0) { sum, province in
                province.isFound ? sum : sum + 1
            }
        }
    }
    
    var delegate: RegionManagerDelegate?
    
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        self.unfilteredRegions = persistenceManager.getRegions()
        self.filteredRegions = unfilteredRegions
    }
    
    func mark(province: Province, asFound isFound: Bool) {
        province.isFound = isFound
        persistenceManager.save()
        
        delegate?.regionManager(self, didUpdateFoundProvinceCount: provincesRemaining)
    }
    
    var count: Int {
        return filteredRegions.count
    }
    
    func provinces(forRegion region: region) -> [Province] {
        return filteredRegions[region] ?? []
    }
    
    func province(at indexPath: IndexPath) -> Province {
        guard let province = filteredRegions[region.forSection(indexPath.section)]?[indexPath.row] else {
            fatalError("Invalid IndexPath")
        }
        
        return province
    }
    
    private func filter(regions: [region:[Province]], query: String) -> [region:[Province]] {
        
        var filteredRegions = [region:[Province]]()
        
        for (region, provinces) in regions {
            let filteredProvinces = provinces.filter({ province in
                return province.name?.lowercased().contains(query.lowercased()) ?? false
            })
            
            if filteredProvinces.count > 0 {
                filteredRegions[region] = filteredProvinces
            }
        }
        
        return filteredRegions
    }
}

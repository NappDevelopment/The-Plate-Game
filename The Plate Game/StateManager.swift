//
//  StateManager.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import Foundation

protocol StateManagerDelegate {
    func stateManager(_ stateManager: StateManager, didUpdateFoundStateCount count: Int)
}

final class StateManager {

    private var persistenceManager: PersistenceManager
    private(set) var states: [State]
    
    var foundStateCount: Int {
        return states.filter({$0.isFound}).count
    }
    
    var delegate: StateManagerDelegate?
    
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        self.states = persistenceManager.getStates()
    }
    
    func markState(at index: Int, asFound isFound: Bool) {
        states[index].isFound = isFound
        persistenceManager.save()
        
        delegate?.stateManager(self, didUpdateFoundStateCount: foundStateCount)
    }
    
}

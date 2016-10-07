//
//  StateListTableViewDataSource.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class StateListTableViewDataSource: NSObject {
    let stateManager: StateManager
    
    init(stateManager: StateManager) {
        self.stateManager = stateManager
        
        super.init()
    }
}

extension StateListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateManager.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StateTableViewCell.identifier, for: indexPath) as! StateTableViewCell
        let state = stateManager.states[indexPath.row]
        
        configureCell(cell, withState: state)
        
        return cell
    }
    
    func configureCell(_ cell: StateTableViewCell, withState state: State) {
        cell.stateName = state.name
        cell.stateNickname = state.nickname
        cell.isFound = state.isFound
    }
}

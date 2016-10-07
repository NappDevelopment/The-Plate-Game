//
//  StateListTableViewDelegate.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/7/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class StateListTableViewDelegate: NSObject {
    let stateManager: StateManager
    
    init(stateManager: StateManager) {
        self.stateManager = stateManager
        
        super.init()
    }
}

extension StateListTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = stateManager.states[indexPath.row]
        
        stateManager.markState(at: indexPath.row, asFound: !state.isFound)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

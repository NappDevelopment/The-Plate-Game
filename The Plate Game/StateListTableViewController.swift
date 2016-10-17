//
//  StateListTableViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

protocol StateListTableViewControllerDelegate {
    func didSelect(state: State)
}


class StateListTableViewController: UITableViewController, StateManagerDelegate {
    
    var tableViewDataSource: StateListTableViewDataSource?
    
    var stateManager: StateManager!
    var states: [State] {
        return stateManager.states
    }
    
    var selectedState: State {
        return states[tableView.indexPathForSelectedRow?.row ?? 0]
    }

    var delegate: StateListTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateManager.delegate = self

        tableViewDataSource = StateListTableViewDataSource(stateManager: stateManager)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(StateTableViewCell.self, forCellReuseIdentifier: StateTableViewCell.identifier)
        tableView.dataSource = tableViewDataSource

        updateNavigationItemTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
       // self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Table View

    func stateManager(_ stateManager: StateManager, didUpdateFoundStateCount count: Int) {
        updateNavigationItemTitle()
    }
    
    func updateNavigationItemTitle() {
        self.navigationItem.title = "\(50 - stateManager.foundStateCount) States Remaining"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = stateManager.states[indexPath.row]
        
        delegate?.didSelect(state: state)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let mark = UITableViewRowAction(style: .normal, title: "Mark") { action, index in
            self.markState(at: index.row)
            
            tableView.isEditing = false
            tableView.reloadRows(at: [index], with: .automatic)
        }
        
        return [mark]
    }
    
    func markState(at index: Int) {
        let state = stateManager.states[index]
        
        stateManager.markState(at: index, asFound: !state.isFound)
    }
}


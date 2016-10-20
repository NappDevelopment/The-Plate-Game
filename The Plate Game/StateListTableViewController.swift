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
    
    private let stateManager: StateManager
    
    var selectedState: State {
        return stateManager.states[tableView.indexPathForSelectedRow?.row ?? 0]
    }

    var delegate: StateListTableViewControllerDelegate?
    
    init(stateManager: StateManager) {
        self.stateManager = stateManager

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stateManager.delegate = self

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(StateTableViewCell.self, forCellReuseIdentifier: StateTableViewCell.identifier)

        updateNavigationItemTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.transitionCoordinator?.notifyWhenInteractionChanges() { context in
                if context.isCancelled {
                    self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                }
            }
        }
    }
    
    func stateManager(_ stateManager: StateManager, didUpdateFoundStateCount count: Int) {
        updateNavigationItemTitle()
    }
    
    func updateNavigationItemTitle() {
        self.navigationItem.title = "\(50 - stateManager.foundStateCount) States Remaining"
    }
    
    // MARK: - Table View DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateManager.states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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


    // MARK: - Table View Delegate
    
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


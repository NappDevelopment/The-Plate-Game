//
//  StateListTableViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class StateListTableViewController: UITableViewController, StateManagerDelegate {

    var detailViewController: DetailViewController? = nil
    
    var tableViewDataSource: StateListTableViewDataSource?
    var tableViewDelegate: StateListTableViewDelegate?
    
    var stateManager: StateManager!
    var states: [State] {
        return stateManager.states
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        stateManager.delegate = self

        tableViewDataSource = StateListTableViewDataSource(stateManager: stateManager)
        tableViewDelegate = StateListTableViewDelegate(stateManager: stateManager)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate

        updateNavigationItemTitle()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(StateTableViewCell.self, forCellReuseIdentifier: StateTableViewCell.identifier)
        
        // Must uncomment to load data into Core Data
        //importJSONData(context: self.managedObjectContext!)
    }

    override func viewWillAppear(_ animated: Bool) {
       // self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = states[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    func stateManager(_ stateManager: StateManager, didUpdateFoundStateCount count: Int) {
        updateNavigationItemTitle()
    }
    
    func updateNavigationItemTitle() {
        self.navigationItem.title = "\(50 - stateManager.foundStateCount) States Remaining"
    }
}


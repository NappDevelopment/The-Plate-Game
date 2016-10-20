//
//  AppCoordinator.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/16/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class AppCoordinator: UISplitViewControllerDelegate, StateListTableViewControllerDelegate {
    
    // MARK: - View Controller References
    
    private let splitViewController: UISplitViewController
     let stateListNavigationController: UINavigationController
     let stateDetailNavigationController: UINavigationController
    
    /// Abstract out the root view controller
    var rootViewController: UIViewController {
        return splitViewController
    }
    
    // MARK: - Initializer
    
    init(with stateManager: StateManager) {
        /// Initialize the main view controllers for the split view
        let stateListTableViewController = StateListTableViewController(stateManager: stateManager)
        let stateDetailViewController = StateDetailViewController(state: stateManager.states[0])
        
        /// Initialize the container view controllers
        splitViewController = UISplitViewController()
        stateListNavigationController = UINavigationController(rootViewController: stateListTableViewController)
        stateDetailNavigationController = UINavigationController(rootViewController: stateDetailViewController)
        
        /// Setup the split view controller
        splitViewController.viewControllers = [stateListNavigationController, stateDetailNavigationController]
        splitViewController.delegate = self
        
        stateListTableViewController.delegate = self
        stateDetailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        return stateListNavigationController
    }
    
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return stateListNavigationController
    }
    
    // MARK: - Coordinator Methods
    
    func didSelect(state: State) {
        let stateDetailViewController = stateDetailNavigationController.topViewController as? StateDetailViewController ?? StateDetailViewController(state: state)
        
        stateDetailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem
        stateDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        
        if stateDetailViewController.state != state {
            stateDetailViewController.state = state
        }
        
        
        stateListNavigationController.pushViewController(stateDetailViewController, animated: true)
        //let top = stateListNavigationController.topViewController as? StateListTableViewController
        //top?.showDetailViewController(stateDetailNavigationController, sender: nil)
        //stateListNavigationController.pushViewController(stateDetailNavigationController, animated: true)
        //splitViewController.showDetailViewController(stateDetailViewController, sender: nil)
        //stateListNavigationController.pushViewController(stateDetailViewController, animated: true)
        //stateDetailNavigationController.show(stateDetailViewController, sender: nil)
//        stateListNavigationController.show(stateDetailViewController, sender: nil)
        //stateListNavigationController.showDetailViewController(stateDetailViewController, sender: nil)
        //stateListNavigationController.showDetailViewController(stateDetailNavigationController, sender: nil)
    }
}

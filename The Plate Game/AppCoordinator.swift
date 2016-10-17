//
//  AppCoordinator.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/16/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class AppCoordinator: UISplitViewControllerDelegate, StateListTableViewControllerDelegate {
    
    private let splitViewController: UISplitViewController
    private let stateListNavigationController: UINavigationController
    private let stateDetailNavigationController: UINavigationController
    
    var rootViewController: UIViewController {
        return splitViewController
    }
    
    init(with stateManager: StateManager) {
        let stateListTableViewController = StateListTableViewController()
        let stateDetailViewController = DetailViewController()
        
        splitViewController = UISplitViewController()
        stateListNavigationController = UINavigationController(rootViewController: stateListTableViewController)
        stateDetailNavigationController = UINavigationController(rootViewController: stateDetailViewController)
        
        splitViewController.viewControllers = [stateListNavigationController, stateDetailNavigationController]
        splitViewController.delegate = self
        stateListTableViewController.stateManager = stateManager

        stateListTableViewController.delegate = self
        stateDetailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        return stateListNavigationController
    }
    
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return stateListNavigationController
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        
        let stateListTableViewController = stateListNavigationController.topViewController as? StateListTableViewController
        let selectedState = stateListTableViewController?.selectedState
        let stateDetailViewController = getDetailViewController()
        
        stateDetailViewController.detailItem = selectedState
        
        return stateDetailNavigationController
    }
    
    func didSelect(state: State) {
        let stateDetailViewController = getDetailViewController()
        
        stateDetailViewController.detailItem = state

        stateListNavigationController.showDetailViewController(stateDetailNavigationController, sender: nil)
    }
    
    func getDetailViewController() -> DetailViewController {
        let stateDetailViewController = stateDetailNavigationController.topViewController as? DetailViewController ?? DetailViewController()
        
        stateDetailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem
        stateDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        
        return stateDetailViewController
    }


}

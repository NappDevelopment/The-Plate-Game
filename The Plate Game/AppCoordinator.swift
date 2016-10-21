//
//  AppCoordinator.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/16/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class AppCoordinator: UISplitViewControllerDelegate, ProvinceListTableViewControllerDelegate {
    
    // MARK: - View Controller References
    
    private let splitViewController: UISplitViewController
    private let provinceListNavigationController: UINavigationController
    private let provinceDetailNavigationController: UINavigationController
    
    /// Abstract out the root view controller
    var rootViewController: UIViewController {
        return splitViewController
    }
    
    // MARK: - Initializer
    
    init(with regionManager: RegionManager) {
        /// Initialize the main view controllers for the split view
        let provinceListTableViewController = ProvinceListTableViewController(regionManager: regionManager)
        let provinceDetailViewController = ProvinceDetailViewController(province: provinceListTableViewController.selectedProvince)
        
        /// Initialize the container view controllers
        splitViewController = UISplitViewController()
        provinceListNavigationController = UINavigationController(rootViewController: provinceListTableViewController)
        provinceDetailNavigationController = UINavigationController(rootViewController: provinceDetailViewController)
        
        /// Setup the split view controller
        splitViewController.viewControllers = [provinceListNavigationController, provinceDetailNavigationController]
        splitViewController.delegate = self
        
        provinceListTableViewController.delegate = self
        provinceDetailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
    
    func primaryViewController(forExpanding splitViewController: UISplitViewController) -> UIViewController? {
        return provinceListNavigationController
    }
    
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return provinceListNavigationController
    }
    
    // MARK: - Coordinator Methods
    
    func didSelect(province: Province) {
        let provinceDetailViewController = provinceDetailNavigationController.topViewController as? ProvinceDetailViewController ?? ProvinceDetailViewController(province: province)
        
        provinceDetailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem
        provinceDetailViewController.navigationItem.leftItemsSupplementBackButton = true
        
        if provinceDetailViewController.province != province {
            provinceDetailViewController.province = province
        }
        
        
        provinceListNavigationController.pushViewController(provinceDetailViewController, animated: true)
    }
}

//
//  ProvinceListTableViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

protocol ProvinceListTableViewControllerDelegate {
    func didSelect(province: Province)
}

class ProvinceListTableViewController: UITableViewController, RegionManagerDelegate {
    
    private let regionManager: RegionManager
    
    var selectedProvince: Province? {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return nil }
        
        return regionManager.province(at: selectedIndexPath)
    }

    var delegate: ProvinceListTableViewControllerDelegate?
    
    init(regionManager: RegionManager) {
        self.regionManager = regionManager

        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regionManager.delegate = self

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(ProvinceTableViewCell.self, forCellReuseIdentifier: ProvinceTableViewCell.identifier)

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
    
    func updateNavigationItemTitle() {
        self.navigationItem.title = "\(regionManager.provincesRemaining) States Remaining"
    }
    
    // MARK: - Region Manager Delegate
    
    func regionManager(_ regionManager: RegionManager, didUpdateFoundProvinceCount count: Int) {
        updateNavigationItemTitle()
    }
    
    // MARK: - Table View DataSource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return region.forSection(section).rawValue
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return regionManager.regions.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionManager.provinces(forRegion: region.forSection(section)).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProvinceTableViewCell.identifier, for: indexPath) as! ProvinceTableViewCell
        let province = regionManager.province(at: indexPath)
        
        configureCell(cell, withProvince: province)
        
        return cell
    }
    
    func configureCell(_ cell: ProvinceTableViewCell, withProvince province: Province) {
        cell.provinceName = province.name
        cell.provinceNickname = province.nickname
        cell.isFound = province.isFound
    }


    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let province = regionManager.province(at: indexPath)
        
        delegate?.didSelect(province: province)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let mark = UITableViewRowAction(style: .normal, title: "Mark") { action, indexPath in
            self.markProvince(at: indexPath)
            
            tableView.isEditing = false
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return [mark]
    }
    
    func markProvince(at indexPath: IndexPath) {
        let province = regionManager.province(at: indexPath)
        
        regionManager.mark(province: province, asFound: !province.isFound)
    }
}


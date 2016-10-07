//
//  StateTableViewCell.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    static let identifier = "StateCell"
    
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var stateNicknameLabel: UILabel!
    
    var stateName: String? {
        didSet {
            stateNameLabel.text = stateName
        }
    }
    
    var stateNickname: String? {
        didSet {
            stateNicknameLabel.text = stateNickname
        }
    }
    
    var isFound = false {
        didSet {
            accessoryType = isFound ? .checkmark : .none
        }
    }
}

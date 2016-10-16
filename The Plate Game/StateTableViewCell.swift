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
    
    var stateNameLabel = UILabel()
    var stateNicknameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let stackView = UIStackView(arrangedSubviews: [stateNameLabel, stateNicknameLabel])

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stateNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stateNicknameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        stateNicknameLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)

        self.addSubview(stackView)
        
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
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

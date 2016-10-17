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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [stateNameLabel, stateNicknameLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stateNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stateNicknameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        stateNicknameLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        stateNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        self.addSubview(stackView)
        
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: margins.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

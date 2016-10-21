//
//  ProvinceTableViewCell.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/6/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class ProvinceTableViewCell: UITableViewCell {
    static let identifier = "ProvinceCell"
    
    var provinceNameLabel = UILabel()
    var provinceNicknameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [provinceNameLabel, provinceNicknameLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        provinceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        provinceNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        provinceNicknameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        provinceNicknameLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        provinceNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
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
    
    var provinceName: String? {
        didSet {
            provinceNameLabel.text = provinceName
        }
    }
    
    var provinceNickname: String? {
        didSet {
            provinceNicknameLabel.text = provinceNickname
        }
    }
    
    var isFound = false {
        didSet {
            accessoryType = isFound ? .checkmark : .none
        }
    }
}

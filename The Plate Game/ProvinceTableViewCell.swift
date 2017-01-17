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
    var provinceImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [provinceNameLabel, provinceNicknameLabel])
        let horizontalStackView = UIStackView(arrangedSubviews: [stackView, provinceImageView])
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        provinceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        provinceNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        provinceNicknameLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .vertical)
        provinceNicknameLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        provinceNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        provinceImageView.image = #imageLiteral(resourceName: "washington")
        provinceImageView.contentMode = .scaleAspectFit
        
        self.addSubview(horizontalStackView)
        
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: margins.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            provinceImageView.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.2),
            provinceImageView.heightAnchor.constraint(equalToConstant: 64)
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

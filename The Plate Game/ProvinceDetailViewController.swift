//
//  ProvinceDetailViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class ProvinceDetailViewController: UIViewController {

    let backgroundImageView = UIImageView()
    let stateImageView = UIImageView()
    let detailDescriptionLabel = UILabel()

    func configureView() {
        if let province = self.province {
            // Update the user interface for the detail item.
            self.navigationItem.title = province.name
            detailDescriptionLabel.text = "Is Found: \(province.isFound)"
        } else {
            self.navigationItem.title = "No state selected"
            detailDescriptionLabel.text = "No State"
        }
    }
    
    init(province: Province?) {
        self.province = province
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        stateImageView.translatesAutoresizingMaskIntoConstraints = false
        detailDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(detailDescriptionLabel)
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(stateImageView)
        
        backgroundImageView.image = #imageLiteral(resourceName: "seattle")
        backgroundImageView.contentMode = .scaleAspectFill
        
        stateImageView.image = #imageLiteral(resourceName: "washington")
        stateImageView.contentMode = .scaleAspectFit

        
        NSLayoutConstraint.activate([
            detailDescriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailDescriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
            
            stateImageView.rightAnchor.constraint(equalTo: backgroundImageView.rightAnchor, constant: -10),
            stateImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -10)
        ])
        
        self.configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
        
        stateImageView.layer.shadowColor = UIColor.black.cgColor
        stateImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        stateImageView.layer.shadowOpacity = 0.7
        stateImageView.layer.shadowRadius = 2
        stateImageView.layer.masksToBounds = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var province: Province? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

}


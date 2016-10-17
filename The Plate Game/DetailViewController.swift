//
//  DetailViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailDescriptionLabel = UILabel()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.navigationItem.title = detail.name?.description
            detailDescriptionLabel.text = "Is Found: \(detail.isFound)"
        }
    }
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .lightGray
        detailDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(detailDescriptionLabel)
        
        NSLayoutConstraint.activate([
            detailDescriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailDescriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: State? {
        didSet {
            // Update the view.
            print(detailItem)
            self.configureView()
        }
    }


}


//
//  StateDetailViewController.swift
//  The Plate Game
//
//  Created by Connor Krupp on 10/4/16.
//  Copyright © 2016 Napp Development. All rights reserved.
//

import UIKit

class StateDetailViewController: UIViewController {

    var detailDescriptionLabel = UILabel()

    func configureView() {
        // Update the user interface for the detail item.
        self.navigationItem.title = state.name
        detailDescriptionLabel.text = "Is Found: \(state.isFound)"
    }
    
    init(state: State) {
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        self.configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var state: State {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

}


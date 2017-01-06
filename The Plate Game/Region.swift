//
//  Region.swift
//  The Plate Game
//
//  Created by Connor Krupp on 1/5/17.
//  Copyright © 2017 Napp Development. All rights reserved.
//

import Foundation

enum region: String {
    case us = "United States"
    case canada = "Canada"
    
    static func forSection(_ index: Int) -> region {
        switch index {
        case 0:
            return .us
        case 1:
            return .canada
        default:
            fatalError("Invalid index for region")
        }
    }
}

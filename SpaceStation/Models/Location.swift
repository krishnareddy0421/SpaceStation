//
//  Location.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import Foundation

// Model to store user's latitude and longitude
struct Location {
    let latitude: Double
    let longitude: Double
    
    func description() {
        print("Latitude: \(latitude) ## Longitude: \(longitude)")
    }
}

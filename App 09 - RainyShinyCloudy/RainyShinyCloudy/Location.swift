//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 14/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() { }
    
    var latitude: Double!
    var longitude: Double!
}

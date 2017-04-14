//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 14/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class Forecast {
    
    private var _date: Date!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var formattedHighTemp: String {
        return String(format: "%.1f", _highTemp)
    }
    
    var formattedLowTemp: String {
        return String(format: "%.1f", _lowTemp)
    }
    
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "da_DK")
        return dateFormatter.string(from: _date).capitalized
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                self._lowTemp = min - 273.15
            }
            
            if let max = temp["max"] as? Double {
                self._highTemp = max - 273.15
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let timeIntervalSince1970 = weatherDict["dt"] as? Double {
            self._date = Date(timeIntervalSince1970: timeIntervalSince1970)
        }
    }
}

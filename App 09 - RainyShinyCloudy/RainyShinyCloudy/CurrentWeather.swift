//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 14/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        
        return _cityName
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "da_DK")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        let date = "I dag, \(currentDate)"

        return date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    
    var formattedTemp: String {
        return String(format: "%.1f", _currentTemp)
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherUrl!).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let cityName = dict["name"] as? String {
                    self._cityName = cityName
                    print(cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let weatherType = weather[0]["main"] as? String {
                        self._weatherType = weatherType
                        print(weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        let currentTempCelsius = currentTemp - 273.15
                        self._currentTemp = currentTempCelsius
                        print(currentTempCelsius)
                    }
                }
                
            }
            completed()
        }
    }
}

//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 13/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import Foundation

let WEATHER_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let CNT = "&cnt=10"
let APP_ID =  "&appid="
let API_KEY = "b304ad647ea8d08d7f87e0940b17c6e9"

let CURRENT_WEATHER_URL = "\(WEATHER_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(CNT)\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()

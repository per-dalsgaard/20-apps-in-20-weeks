//
//  WeatherViewController.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 13/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            let currentLocation = locationManager.location
            Location.sharedInstance.longitude = currentLocation?.coordinate.longitude
            Location.sharedInstance.latitude = currentLocation?.coordinate.latitude
            
            print(CURRENT_WEATHER_URL)
            print(FORECAST_URL)

            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell {
            cell.configureCell(forecast: forecasts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastUrl = URL(string: FORECAST_URL)!
        Alamofire.request(forecastUrl).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for forecastDict in list {
                        let forecast = Forecast(weatherDict: forecastDict)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                }
            }
            completed()
        }
    }
    
    func updateUI() {
        dateLabel.text = currentWeather.formattedDate
        currentTempLabel.text = "\(currentWeather.formattedTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImageView.image = UIImage(named: currentWeather.weatherType)
        
        tableView.reloadData()
    }
}


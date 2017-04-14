//
//  WeatherTableViewCell.swift
//  RainyShinyCloudy
//
//  Created by Per Kristensen on 14/04/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!

    func configureCell(forecast: Forecast) {
        weatherIconImageView.image = UIImage(named: "\(forecast.weatherType) Mini")
        dayLabel.text = forecast.formattedDate
        weatherTypeLabel.text = forecast.weatherType
        highTempLabel.text = forecast.formattedHighTemp
        lowTempLabel.text = forecast.formattedLowTemp
    }
}

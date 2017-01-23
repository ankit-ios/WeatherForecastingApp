//
//  WFCityWeatherListTableViewCell.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

/// WFCityWeatherListTableViewCell table view cell
class WFCityWeatherListTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityWeatherLabel: UILabel!
    
    func configureCell(with city: WFCity, tempUnit: TempUnit) {
        cityNameLabel.text = city.cityName ?? ""
        
        let temp = city.currentWeather
        let weather = tempUnit == .celsius ? "\(temp?.currentTempInCelsius ?? "") ºC" : "\(temp?.currentTempInFahrenheit ?? "") ºF"
        cityWeatherLabel.text = "\(weather)"
    }
}

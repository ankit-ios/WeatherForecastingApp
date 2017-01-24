//
//  WFCityWeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 17/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

/// WFCityWeatherTableViewCell table view cell
class WFCityWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    
    func configureCell(with weather: WFCityWeather, tempUnit: TempUnit) {
        dateLabel.text = convertDateFormate(weather.date ?? "")
        
        let tempInCelsius = "\(weather.maxTempInCelsius ?? "") ºC / \(weather.minTempInCelsius ?? "") ºC"
        let tempInFehrenheit = "\(weather.maxTempInFehrenheit ?? "") ºF / \(weather.minTempInFehrenheit ?? "") ºF"
        tempLabel.text = tempUnit == .celsius ? tempInCelsius : tempInFehrenheit
    }
    
    /**
     This private method is used for converting date format.
     
     - parameter date: date, which we access from server
     
     - returns: return new date format after converting
     */
    private func convertDateFormate(date: String) -> String {
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateFormat = kY_M_D
        let date = dateformatter.dateFromString(date)
        
        dateformatter.dateFormat = kD_M_Y
        return dateformatter.stringFromDate(date ?? NSDate())
    }
}

//
//  WFWeather.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

struct WFWeather {
    
    var date: String
    var maxTempInCelsius: String
    var minTempInCelsius: String
    var maxTempInFehrenheit: String
    var minTempInFehrenheit: String
    
    init() {
        
        self.date = ""
        self.maxTempInCelsius = ""
        self.minTempInCelsius = ""
        self.maxTempInFehrenheit = ""
        self.minTempInFehrenheit = ""
    }
}

struct WFCurrentWeather {
    var currentTempInCelsius: String
    var currentTempInFahrenheit: String
    var currentWeatherIconUrl: String
    var currentWeatherDesc: String
    
    init() {
        self.currentTempInCelsius = ""
        self.currentTempInFahrenheit = ""
        self.currentWeatherIconUrl = ""
        self.currentWeatherDesc = ""
    }
}
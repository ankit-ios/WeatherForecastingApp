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
    
    init(object: AnyObject) {
        self.date = object["date"] as? String ?? ""
        self.maxTempInCelsius = object["maxtempC"] as? String ?? ""
        self.minTempInCelsius = object["mintempC"] as? String ?? ""
        self.maxTempInFehrenheit = object["maxtempF"] as? String ?? ""
        self.minTempInFehrenheit = object["mintempF"] as? String ?? ""
    }
    
    static func constractModel(data: [String: AnyObject]) -> [WFWeather] {
        let weatherArray = data["weather"] as? NSArray ?? NSArray()
        return weatherArray.map({ object in
            WFWeather(object: object)
        })
    }
}

struct WFCurrentWeather {
    var currentTempInCelsius: String
    var currentTempInFahrenheit: String
    var currentWeatherIconUrl: String
    var currentWeatherDesc: String
    
    init(object: AnyObject) {
        self.currentTempInCelsius = object["temp_C"] as? String ?? ""
        self.currentTempInFahrenheit = object["temp_F"] as? String ?? ""
        self.currentWeatherIconUrl = object["weatherIconUrl"]!![0]["value"] as? String ?? ""
        self.currentWeatherDesc = object["weatherDesc"]!![0]["value"] as? String ?? ""
    }
    
    static func constractModel(data: [String: AnyObject]) -> WFCurrentWeather {
        let currentCondition = data["current_condition"]![0]
        return WFCurrentWeather(object: currentCondition)
    }
}




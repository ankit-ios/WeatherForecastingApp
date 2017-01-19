//
//  WFWeather.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WFWeather {
    
    var date: String
    var maxTempInCelsius: String
    var minTempInCelsius: String
    var maxTempInFehrenheit: String
    var minTempInFehrenheit: String
    
    init(object: AnyObject) {
        let jsonObject = JSON(object)
        self.date = jsonObject["date"].stringValue
        self.maxTempInCelsius = jsonObject["maxtempC"].stringValue
        self.minTempInCelsius = jsonObject["mintempC"].stringValue
        self.maxTempInFehrenheit = jsonObject["maxtempF"].stringValue
        self.minTempInFehrenheit = jsonObject["mintempF"].stringValue
    }
    
    static func constructModel(data: [String: AnyObject]) -> [WFWeather] {
        let weatherArray = JSON(data)["weather"].arrayObject ?? NSArray()
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
        let jsonObject = JSON(object)
        self.currentTempInCelsius = jsonObject["temp_C"].stringValue
        self.currentTempInFahrenheit = jsonObject["temp_F"].stringValue
        self.currentWeatherIconUrl = jsonObject["weatherIconUrl",0,"value"].stringValue
        self.currentWeatherDesc = jsonObject["weatherDesc",0,"value"].stringValue
    }
    
    static func constructModel(data: [String: AnyObject]) -> WFCurrentWeather {
        let currentCondition = JSON(data)["current_condition",0].dictionaryObject
        return WFCurrentWeather(object: currentCondition ?? Dictionary())
    }
}




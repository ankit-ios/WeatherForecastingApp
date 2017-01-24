//
//  WFCityWeather.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

/// This model class is used for creating object with weather forecast information
class WFCityWeather {
    
    let date: String?
    let maxTempInCelsius: String?
    let minTempInCelsius: String?
    let maxTempInFehrenheit: String?
    let minTempInFehrenheit: String?
    
    //This initializer is used for parsing the API response
    init(object: AnyObject) {
        let jsonObject = JSON(object)
        self.date = jsonObject["date"].string
        self.maxTempInCelsius = jsonObject["maxtempC"].string
        self.minTempInCelsius = jsonObject["mintempC"].string
        self.maxTempInFehrenheit = jsonObject["maxtempF"].string
        self.minTempInFehrenheit = jsonObject["mintempF"].string
    }
    
    static func constructModel(data: [String: AnyObject]?) -> [WFCityWeather]? {
        guard let data = data else {return nil}
        
        if let weatherArray = JSON(data)["weather"].arrayObject {
            return weatherArray.map({ object in
                WFCityWeather(object: object)
            })
        }
        return nil
    }
}

/// This model class is used for creating object with weather current information
class WFCurrentCityWeather {
    let currentTempInCelsius: String?
    let currentTempInFahrenheit: String?
    let currentWeatherDesc: String?
    
    //This initializer is used for parsing the API response
    init(object: AnyObject) {
        let jsonObject = JSON(object)
        self.currentTempInCelsius = jsonObject["temp_C"].string
        self.currentTempInFahrenheit = jsonObject["temp_F"].string
        self.currentWeatherDesc = jsonObject["weatherDesc",0,"value"].string
    }
    
    static func constructModel(data: [String: AnyObject]?) -> WFCurrentCityWeather? {
        guard let data = data else {return nil}
        if let currentCondition = JSON(data)["current_condition",0].dictionaryObject {
            return WFCurrentCityWeather(object: currentCondition)
        }
        return nil
    }
}




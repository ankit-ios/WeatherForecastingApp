//
//  WFCity.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WFCity: Equatable {
    
    var cityName: String
    var currentWeather: WFCurrentWeather
    var forecastWeather: [WFWeather]
    
    init(object: AnyObject) {
        let jsonObject = JSON(object)
        self.cityName = jsonObject["request",0,"query"].stringValue
        self.currentWeather = WFCurrentWeather.constructModel(jsonObject.dictionaryObject ?? Dictionary())
        self.forecastWeather = WFWeather.constructModel(jsonObject.dictionaryObject ?? Dictionary())
    }
    
    static func constructModel(data: [String: AnyObject]) -> WFCity {
        let cityData = JSON(data)["data"].dictionaryObject
        print(cityData)
        return WFCity(object: cityData ?? Dictionary())
    }
}

func ==(lhs: WFCity, rhs: WFCity) -> Bool {
    return lhs.cityName == rhs.cityName
}


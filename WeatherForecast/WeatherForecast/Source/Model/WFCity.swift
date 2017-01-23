//
//  WFCity.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

///The WFCity class use for creating object of City, which have current weather and next 5 days forecast weather information.
class WFCity: Equatable {
    
    let cityName: String?
    let currentWeather: WFCurrentWeather?
    let forecastWeather: [WFWeather]?
    
    //This initializer is used for parsing the API response
    init(object: AnyObject) {
        let jsonObject = JSON(object)
        self.cityName = jsonObject["request",0,"query"].string
        self.currentWeather = WFCurrentWeather.constructModel(jsonObject.dictionaryObject)
        self.forecastWeather = WFWeather.constructModel(jsonObject.dictionaryObject)
    }
    
    static func constructModel(data: [String: AnyObject]?) -> WFCity? {
        if let data = data {
            if let cityData = JSON(data)["data"].dictionaryObject {
                return WFCity(object: cityData)
            }
        }
        return nil
    }
}


//Returns `true` if `lhs` is equal to `rhs`
func ==(lhs: WFCity, rhs: WFCity) -> Bool {
    return lhs.cityName == rhs.cityName
}


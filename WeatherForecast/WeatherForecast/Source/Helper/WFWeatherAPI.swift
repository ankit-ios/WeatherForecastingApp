//
//  WFWeatherAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

struct WFWeatherAPI {
    static let baseURL = "https://api.worldweatheronline.com/premium/v1"
    static let apiKey = "0cbbbbf2ee2344ef90a64938171101"
    static let searchString = "/search.ashx"
    static let weatherString = "/weather.ashx"
    static let keyParam = "?key="
    static let nameParam = "&q="
    static let formatParam = "&format=json"
    static let dayParam = "&num_of_days=5"
    static let dateParam = "&date=today"
    
    enum APIs {
        case SeachCity(text: String)
        case CityWeather(cityName: String)
        
        func urlString() -> String {
            switch self {
            case .SeachCity(let text):
                return baseURL+searchString+keyParam+apiKey+nameParam+text+formatParam
                
            case .CityWeather(let cityName):
                return baseURL+weatherString+keyParam+apiKey+nameParam+cityName+formatParam+dayParam+dateParam
            }
        }
    }
}


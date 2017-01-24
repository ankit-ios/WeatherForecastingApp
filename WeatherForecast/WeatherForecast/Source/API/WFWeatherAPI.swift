//
//  WFCityWeatherAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation

/**
Getting URL from API
 - SearchCity:  url for all searched city
 - CityWeather: url for weather of given city
 */
enum WFCityWeatherAPI {
    
    case SearchCity(searchString: String)
    case CityWeather(cityName: String)
    
    func urlString() -> String {
        switch self {
        case .SearchCity(let searchString):
            return kWeatherBaseURL+kSearchString+kKeyParam+kWeatherAPIKey+kNameParam+searchString+kFormatParam
            
        case .CityWeather(let cityName):
            return kWeatherBaseURL+kWeatherString+kKeyParam+kWeatherAPIKey+kNameParam+cityName+kFormatParam+kDayParam+kDateParam
        }
    }
}


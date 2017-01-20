//
//  WFWeatherAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

enum WFWeatherAPI {
    
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


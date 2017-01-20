//
//  WFWeatherAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

enum WFWeatherAPI {
    
    case SeachCity(text: String)
    case CityWeather(cityName: String)
    
    func urlString() -> String {
        switch self {
        case .SeachCity(let text):
            return kWeatherBaseURL+kSearchString+kKeyParam+kWeatherAPIKey+kNameParam+text+kFormatParam
            
        case .CityWeather(let cityName):
            return kWeatherBaseURL+kWeatherString+kKeyParam+kWeatherAPIKey+kNameParam+cityName+kFormatParam+kDayParam+kDateParam
        }
    }
}


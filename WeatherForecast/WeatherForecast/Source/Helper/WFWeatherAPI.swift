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
            return kBaseURL+kSearchString+kKeyParam+kAPIKey+kNameParam+text+kFormatParam
            
        case .CityWeather(let cityName):
            return kBaseURL+kWeatherString+kKeyParam+kAPIKey+kNameParam+cityName+kFormatParam+kDayParam+kDateParam
        }
    }
}


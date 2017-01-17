//
//  WebServiceManager.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import Alamofire


struct WeatherAPI {
    static let weatherBaseURL = "https://api.worldweatheronline.com/premium/v1"
    static let weatherAPIKey = "0cbbbbf2ee2344ef90a64938171101"
    static let searchString = "/search.ashx"
    static let weatherString = "/weather.ashx"
    
    enum URLs {
        case SeachCity
        case CityWeather
        
        func urlString() -> String {
            switch self {
            case .SeachCity:
                return weatherBaseURL + searchString
                
            case .CityWeather:
                return weatherBaseURL + weatherString
            }
        }
    }
}

struct WFWebServiceManager {
    
    static func getSeachedCities(text: String, completion: (searchedCity: AnyObject?, error: NSError?) -> Void) {
        
        Alamofire.request(.GET, "\(WeatherAPI.URLs.urlString(.SeachCity)())?key=\(WeatherAPI.weatherAPIKey)&q=\(text)&format=json").responseJSON { (request, response, result) in
            
            print("\(WeatherAPI.URLs.urlString(.SeachCity)())?key=\(WeatherAPI.weatherAPIKey)&q=\(text)&format=json")
            if let response = response where response.statusCode == 200 {
                completion(searchedCity: result.value, error: nil)
            } else {
                completion(searchedCity: nil, error: nil)
            }
        }
    }
    
    static func getCityWeather(cityName: String, completion: (cityWeather: AnyObject?, error: NSError?) -> Void) {
        print("\(WeatherAPI.URLs.urlString(.SeachCity)())?key=\(WeatherAPI.weatherAPIKey)&q=\(cityName)&format=json")

        Alamofire.request(.GET, "\(WeatherAPI.URLs.urlString(.CityWeather)())?key=\(WeatherAPI.weatherAPIKey)&q=\(cityName)&format=json&num_of_days=5&date=today").responseJSON { (request, response, result) in
            
            print("\(WeatherAPI.URLs.urlString(.SeachCity)())?key=\(WeatherAPI.weatherAPIKey)&q=\(cityName)&format=json")
            
                        if let response = response where response.statusCode == 200 {
                            completion(cityWeather: result.value, error: nil)
                        } else {
                            completion(cityWeather: nil, error: nil)
                        }
        }
        
    }
    
}

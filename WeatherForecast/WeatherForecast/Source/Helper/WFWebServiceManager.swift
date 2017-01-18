//
//  WebServiceManager.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import Alamofire

struct WFWebServiceManager {
    
    typealias completionHandler = (response: AnyObject?, error: NSError?) -> Void
    
    static func getSeachedCities(text: String, onCompletion: completionHandler) {
      
        let urlString = WFWeatherAPI.APIs.urlString(.SeachCity(text: text))
        makeHTTPGetRequest(urlString().removeSpace) { response, error in
            onCompletion(response: response, error: error)
        }
    }
    
    static func getCityWeather(cityName: String, onCompletion: completionHandler) {
        
        let urlString = WFWeatherAPI.APIs.urlString(.CityWeather(cityName: cityName))
        makeHTTPGetRequest(urlString().removeSpace) { response, error in
            onCompletion(response: response, error: error)
        }
    }
    
    static func makeHTTPGetRequest(path: String, onCompletion: completionHandler) {
        
        Alamofire.request(.GET, path).responseJSON { (request, response, result) in
            if let response = response where response.statusCode == 200 {
                onCompletion(response: result.value, error: nil)
            } else {
                onCompletion(response: nil, error: nil)
            }
        }
    }
    
    static func getWeatherIcon(urlString: String, onCompletion: (imageData: NSData?, error: NSError?) -> Void) {
        Alamofire.request(.GET, urlString).responseData { (request, respose, result) in
            if let respose = respose where respose.statusCode == 200 {
                onCompletion(imageData: result.value, error: nil)
            } else {
                onCompletion(imageData: nil, error: nil)
            }
        }
    }
}

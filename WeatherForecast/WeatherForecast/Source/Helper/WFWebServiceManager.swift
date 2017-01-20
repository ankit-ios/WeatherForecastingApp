//
//  WebServiceManager.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct WFWebServiceManager {
    
    typealias completionHandlerForJSON = (response: AnyObject?, error: NSError?) -> Void
    typealias completionHandlerForData = (response: NSData?, error: NSError?) -> Void

    
    static func getSeachedCities(searchString: String, onCompletion: completionHandlerForJSON) {
      
        let urlString = WFWeatherAPI.urlString(.SearchCity(searchString: searchString))
        makeHTTPGetRequestForJSON(urlString().removeSpace) { response, error in
            onCompletion(response: response, error: error)
        }
    }
    
    static func getCityWeather(cityName: String, onCompletion: completionHandlerForJSON) {
        
        let urlString = WFWeatherAPI.urlString(.CityWeather(cityName: cityName))
        makeHTTPGetRequestForJSON(urlString().removeSpace) { response, error in
            onCompletion(response: response, error: error)
        }
    }
    
    static func getWeatherIcon(urlString: String, onCompletion: completionHandlerForData) {
        
        makeHTTPGetRequestForData(urlString) { (response, error) in
            onCompletion(response: response,error: error)
        }
    }
    
    static func getImageFromFlickrSearch(searchString: String, onCompletion: (completionHandlerForData)) {
    
        let urlString = WFFlickrAPI.URLForSearchString(searchString)
        makeHTTPGetRequestForJSON(urlString) { (response, error) in
         
            if let response = response {
                let flickerPhoto = WFFlickrPhoto.constructModel(JSON(response)["photos","photo",0].dictionaryObject ?? Dictionary())
                let urlString = WFFlickrAPI.URLForFlickrPhoto(flickerPhoto, size: "b")
                
                makeHTTPGetRequestForData(urlString, onCompletion: { (response, error) in
                    onCompletion(response: response, error: error)
                })
            }
        }
    }
    
    static func makeHTTPGetRequestForJSON(path: String, onCompletion: completionHandlerForJSON) {
        
        Alamofire.request(.GET, path).responseJSON { (request, response, result) in
            
            if let json = result.value where response?.statusCode == 200 {
                onCompletion(response: json, error: nil)
            } else {
                onCompletion(response: nil, error: nil)
            }
        }
    }
    

    static func makeHTTPGetRequestForData(urlString: String, onCompletion: (completionHandlerForData)) {
    
        Alamofire.request(.GET, urlString).responseData { (request, respose, result) in
            if let respose = respose where respose.statusCode == 200 {
                onCompletion(response: result.value, error: nil)
            } else {
                onCompletion(response: nil, error: nil)
            }
        }

    }
}

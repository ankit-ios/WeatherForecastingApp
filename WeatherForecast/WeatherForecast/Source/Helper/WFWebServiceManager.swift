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

/**
 *  This WFWebServiceManager is act for handling all network requests and responses.
 */
struct WFWebServiceManager {
    
    typealias completionHandlerForJSON = (response: AnyObject?, error: NSError?) -> Void
    typealias completionHandlerForData = (response: NSData?, error: NSError?) -> Void
    
    /**
     Getting json response about searched cities
     
     - parameter searchString: city name
     - parameter onCompletion: return seached city
     */
    static func getSeachedCities(searchString: String, onCompletion: (response: [WFSearchCity]?, error: NSError?) -> Void) {
        
        let urlString = WFCityWeatherAPI.urlString(.SearchCity(searchString: searchString))
        makeHTTPGetRequestForJSON(urlString().removeSpace) { response, error in
            
            if let response = response where error == nil {
                if let searchedCities = WFSearchCity.constructModel(response) {
                    onCompletion(response: searchedCities, error: nil)
                }
                else {
                    onCompletion(response: nil, error: WFError.getWrongDataError())
                }
            } else {
                onCompletion(response: nil, error: error)
            }
        }
    }
    
    /**
     Getting json response about cities weather
     
     - parameter cityName:     city name
     - parameter onCompletion: return city weather
     */
    static func getCityWeather(cityName: String, onCompletion: (response: WFCity?, error: NSError?) -> Void) {
        
        let urlString = WFCityWeatherAPI.urlString(.CityWeather(cityName: cityName))
        makeHTTPGetRequestForJSON(urlString().removeSpace) { response, error in
            
            if let response = response where error == nil {
                if let newCityWeather = WFCity.constructModel(response as? [String: AnyObject]) {
                    onCompletion(response: newCityWeather, error: nil)
                } else {
                    onCompletion(response: nil, error: WFError.getWrongDataError())
                }
            } else {
                onCompletion(response: nil, error: error)
            }
        }
    }
    
    /**
     Getting image data for search string
     
     - parameter searchString: search string for image
     - parameter onCompletion: return image data
     */
    static func getImageFromFlickrSearch(searchString: String, onCompletion: (completionHandlerForData)) {
        
        let urlString = WFFlickrAPI.URLForSearchString(searchString.removeSpace)
        makeHTTPGetRequestForJSON(urlString) { (response, error) in
            
            if let response = response {
                if let flickerPhoto = WFFlickrPhoto.constructModel(response) {
                    let urlString = WFFlickrAPI.URLForFlickrPhoto(flickerPhoto)
                    
                    makeHTTPGetRequestForData(urlString, onCompletion: { (response, error) in
                        onCompletion(response: response, error: error)
                    })
                } else {
                    onCompletion(response: nil, error: WFError.getWrongDataError())
                }
            } else {
                onCompletion(response: nil, error: error)
            }
        }
    }
    
    /**
     make request for getting response in json format
     
     - parameter path:         url for getting json data
     - parameter onCompletion: return response in json format
     */
    static func makeHTTPGetRequestForJSON(path: String, onCompletion: completionHandlerForJSON) {
        
        Alamofire.request(.GET, path).responseJSON { (request, response, result) in
            
            switch result {
            case .Success(let value):
                onCompletion(response: value, error: nil)
            case .Failure(_, let error):
                onCompletion(response: nil, error: error as? NSError ?? WFError.getServerError())
            }
        }
    }
    
    /**
     make request for getting response in data format
     
     - parameter urlString:    url for getting reponse in data format
     - parameter onCompletion: return response
     */
    static func makeHTTPGetRequestForData(urlString: String, onCompletion: (completionHandlerForData)) {
        
        Alamofire.request(.GET, urlString).responseData { (request, respose, result) in
            
            switch result {
            case .Success(let value):
                onCompletion(response: value, error: nil)
            case .Failure(_, let error):
                onCompletion(response: nil, error: error as? NSError ?? WFError.getServerError())
            }
        }
    }
}







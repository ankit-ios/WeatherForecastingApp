//
//  WebServiceManager.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit



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

class WebServiceManager {
    
    var searchedCity = [SearchedCity]()
    typealias JSONFormat = [String: AnyObject]
    
    func getSeachedCities(text: String, completion: (searchedCity: [SearchedCity]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(NSURL(string: "\(WeatherAPI.URLs.urlString(.SeachCity)())?key=\(WeatherAPI.weatherAPIKey)&q=\(text)&format=json") ?? NSURL()) { (data, response, error) in
            
            if let data = data where error == nil  {
                do {
                    let searchCities = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! JSONFormat
                    
                    if let cities = searchCities["search_api"]?["result"] as? NSArray {
                        self.searchedCity = cities.map {SearchedCity(cityName: $0["areaName"]!![0]["value"] as? String ?? "", cityRegion: $0["region"]!![0]["value"] as? String ?? "", cityCountry: $0["country"]!![0]["value"] as? String ?? "")}
                    }
                    
                    completion(searchedCity: self.searchedCity, error: nil)
                    
                } catch let jsonError as NSError {
                    completion(searchedCity: nil, error: jsonError)
                }
            }
            completion(searchedCity: nil, error: nil)
        }
        dataTask.resume()
    }
    
    
    func getCityWeather(cityName: String, completion: (searchedCity: [SearchedCity]?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(NSURL(string: "\(WeatherAPI.URLs.urlString(.CityWeather)())?key=\(WeatherAPI.weatherAPIKey)&q=\(cityName)&format=json&num_of_days=5&date=today") ?? NSURL()) { (data, response, error) in
            
            if let data = data where error == nil  {
                
                
                do {
                    
                    let searchCities = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! JSONFormat
                    
                    
                    completion(searchedCity: self.searchedCity, error: nil)
                    
                } catch let jsonError as NSError {
                    completion(searchedCity: nil, error: jsonError)
                }
            }
        }
        dataTask.resume()
    }
}

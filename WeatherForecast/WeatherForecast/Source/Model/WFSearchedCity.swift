//
//  City.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

struct WFSearchedCity {
    
    var cityName: String
    var cityCountry: String
    var cityRegion: String
    
    init(object : [String: AnyObject]) {
        self.cityName = object["areaName"]?[0]["value"] as? String ?? ""
        self.cityRegion  = object["region"]?[0]["value"] as? String ?? ""
        self.cityCountry = object["country"]?[0]["value"] as? String ?? ""
    }
    
    static func constructModel(data: AnyObject) -> [WFSearchedCity] {
        if let search = data["search_api"] {
            if let result = search?["result"] as? NSArray {
                
                return result.map { object in
                    WFSearchedCity(object: object as! [String: AnyObject])
                }
            }
        }
        return [WFSearchedCity]()
    }
}




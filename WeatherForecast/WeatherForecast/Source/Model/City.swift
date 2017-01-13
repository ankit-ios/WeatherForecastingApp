//
//  City.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

class City {
    
    
    
}

struct SearchedCity {
    
    var cityName: String
    var cityCountry: String
    var cityRegion: String
    
    init(cityName: String, cityRegion: String, cityCountry: String) {
        self.cityName = cityName
        self.cityRegion = cityRegion
        self.cityCountry = cityCountry
    }
    
//    static func constractModel(object: [String: AnyObject]) -> [SearchedCity] {
//        
//        let ss: [SearchedCity] = object.map{SearchedCity(cityName: $0["areaName"]![0]["value"] as? String ?? "", cityRegion: $0["region"]![0]["value"] as? String ?? "", cityCountry: $0["country"]![0]["value"] as? String ?? "")}
//        return ss
//    }
}




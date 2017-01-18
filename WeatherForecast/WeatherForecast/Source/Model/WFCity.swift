//
//  WFCity.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

struct WFCity: Equatable {
    
    var cityName: String
    var currentWeather: WFCurrentWeather
    var forecastWeather: [WFWeather]
    
    init(object: AnyObject) {
        
            self.cityName = object["request"]!![0]["query"] as? String ?? ""
            self.currentWeather = WFCurrentWeather.constractModel(object as! [String : AnyObject])
            self.forecastWeather = WFWeather.constractModel(object as! [String : AnyObject])
    }
    
    static func constractModel(data: [String: AnyObject]) -> WFCity {
        
        let cityData = data["data"]
        print(cityData!)
        return WFCity(object: cityData!)
    }
}

func ==(lhs: WFCity, rhs: WFCity) -> Bool {
    return lhs.cityName == rhs.cityName
}


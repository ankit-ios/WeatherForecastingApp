//
//  WFCity.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WFCity {
    
    var cityName: String
    var currentWeather: WFCurrentWeather
    var forecastWeather: [WFWeather]
    
    init(object: AnyObject?) {
        
        if let object = object {
            
            self.cityName = object["request"]!![0]["query"] as? String ?? ""
            
            var currentWeather = WFCurrentWeather()
            currentWeather.currentTempInCelsius = object["current_condition"]!![0]["temp_C"] as? String ?? ""
            currentWeather.currentTempInFahrenheit = object["current_condition"]!![0]["temp_F"] as? String ?? ""
            currentWeather.currentWeatherIconUrl = object["current_condition"]!![0]["weatherIconUrl"]!![0]["value"] as? String ?? ""
            currentWeather.currentWeatherDesc = object["current_condition"]!![0]["weatherDesc"]!![0]["value"] as? String ?? ""
            
            self.currentWeather = currentWeather
            
            var forecastWeather = [WFWeather]()

            let weathers = object["weather"] as? NSArray
            
            for weather in weathers! {
                
                var wtr = WFWeather()
                wtr.date = weather["date"] as? String ?? ""
                wtr.maxTempInCelsius = weather["maxtempC"] as? String ?? ""
                wtr.minTempInCelsius = weather["mintempC"] as? String ?? ""
                wtr.maxTempInFehrenheit = weather["maxtempF"] as? String ?? ""
                wtr.minTempInFehrenheit = weather["mintempF"] as? String ?? ""
                
                forecastWeather.append(wtr)
            }
            
            self.forecastWeather = forecastWeather
       
        } else {
            self.cityName = ""
            self.currentWeather = WFCurrentWeather()
            self.forecastWeather = [WFWeather]()
        }
    }
    
    static func constractModelWithJson(json: AnyObject) -> WFCity {
        
        let cityData = json["data"]
        print(cityData!)
        return WFCity(object: cityData)
    }
}

//
//  City.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

struct WFSearchedCity {
    
    var cityName: String
    var cityCountry: String
    var cityRegion: String
    
    init(object : [String: AnyObject]) {
        let jsonObject = JSON(object)
        self.cityName = jsonObject["areaName",0,"value"].stringValue
        self.cityRegion  = jsonObject["region",0,"value"].stringValue
        self.cityCountry = jsonObject["country",0,"value"].stringValue
    }
    
    static func constructModel(data: AnyObject) -> [WFSearchedCity] {
        
        let results = JSON(data)["search_api","result"].arrayObject ?? NSArray()
        return results.map({ result in
            WFSearchedCity(object: result as? Dictionary ?? Dictionary())
        })
    }
}




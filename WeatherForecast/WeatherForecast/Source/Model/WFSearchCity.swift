//
//  City.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

/// This WFSearchCity is used for getting information about searched city.
class WFSearchCity {
    
    let cityName: String?
    let cityCountry: String?
    let cityRegion: String?
    
    //This initializer is used for parsing the API response
    init(object : [String: AnyObject]) {
        let jsonObject = JSON(object)
        self.cityName = jsonObject["areaName",0,"value"].string
        self.cityRegion  = jsonObject["region",0,"value"].string
        self.cityCountry = jsonObject["country",0,"value"].string
    }
    
    static func constructModel(data: AnyObject?) -> [WFSearchCity]? {
        guard let data = data else {return nil}
        if let results = JSON(data)["search_api","result"].arrayObject {
            var searchCities = [WFSearchCity]()
            
            for result in results {
                if let result = result as? [String: AnyObject] {
                    searchCities.append(WFSearchCity(object: result))
                }
            }
            return searchCities
        }
        return nil
    }
}




//
//  WFFlickrPhoto.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 20/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WFFlickrPhoto {

    var photoID: String
    var farm: Int
    var server: String
    var secret: String
    
    init(object: [String: AnyObject]) {
        let jsonObject = JSON(object)
        self.photoID = jsonObject["id"].stringValue
        self.farm = jsonObject["farm"].intValue
        self.server = jsonObject["server"].stringValue
        self.secret = jsonObject["secret"].stringValue
    }
    
    static func constructModel(data: AnyObject) -> WFFlickrPhoto {
        return WFFlickrPhoto(object: JSON(data).dictionaryObject ?? Dictionary())
    }
}

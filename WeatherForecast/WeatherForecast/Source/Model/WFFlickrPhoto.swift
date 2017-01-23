//
//  WFFlickrPhoto.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 20/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

/// This WFFlickrPhoto strct is used for getting image infromation from flickr api.
struct WFFlickrPhoto {
    
    let photoID: String?
    let farm: Int?
    let server: String?
    let secret: String?

    //This initializer is used for parsing the API response
    init(object: [String: AnyObject]) {
        let jsonObject = JSON(object)
        self.photoID = jsonObject["id"].string
        self.farm = jsonObject["farm"].int
        self.server = jsonObject["server"].string
        self.secret = jsonObject["secret"].string
    }
    
    static func constructModel(data: AnyObject?) -> WFFlickrPhoto? {
        guard let data = data else {return nil}
        if let object = JSON(data)["photos","photo",0].dictionaryObject {
            return WFFlickrPhoto(object: object)
        }
        return nil
    }
}

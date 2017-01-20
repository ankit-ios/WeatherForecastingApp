//
//  WFFlickrAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 20/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation

struct WFFlickrAPI {

    static func URLForSearchString(searchString: String) -> String {
        return kFlickrBaseURL+kFlickrSearchMethod+"&api_key="+kFlickrAPIKey+"&text=\(searchString)"+kFlickrGroupID+kFlickrPage+kFormatParam+kFlickrJSONCallBack
    }
    
    static func URLForFlickrPhoto(photo: WFFlickrPhoto, size: String = "m") -> String {
        return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(size).jpg"
    }
}




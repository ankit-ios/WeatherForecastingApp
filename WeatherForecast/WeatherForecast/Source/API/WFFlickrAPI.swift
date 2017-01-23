//
//  WFFlickrAPI.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 20/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation

/**
 *  Flickr API, getting url for background image.
 */
struct WFFlickrAPI {

    static func URLForSearchString(searchString: String) -> String {
        return kFlickrBaseURL+kFlickrSearchMethod+"&api_key="+kFlickrAPIKey+"&text=\(searchString)"+kFlickrGroupID+kFlickrPage+kFormatParam+kFlickrJSONCallBack
    }
    
    static func URLForFlickrPhoto(photo: WFFlickrPhoto, size: String = "b") -> String {
        return "http://farm\(photo.farm ?? 0).staticflickr.com/\(photo.server ?? "")/\(photo.photoID ?? "")_\(photo.secret ?? "")_\(size).jpg"
    }
}




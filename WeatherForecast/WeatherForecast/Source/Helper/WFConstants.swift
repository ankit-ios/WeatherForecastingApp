//
//  WFConstants.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation

//All Constants

//Weather (World Weather Online) API
let kWeatherBaseURL = "https://api.worldweatheronline.com/premium/v1"
let kWeatherAPIKey = "0cbbbbf2ee2344ef90a64938171101"
let kSearchString = "/search.ashx"
let kWeatherString = "/weather.ashx"
let kKeyParam = "?key="
let kNameParam = "&q="
let kFormatParam = "&format=json"
let kDayParam = "&num_of_days=5"
let kDateParam = "&date=today"

//Flickr API
let kFlickrBaseURL = "https://api.flickr.com/services/rest/?"
let kFlickrAPIKey = "3473b56ab7072edfde6d209f43336f12"
let kFlickrSearchMethod = "method=flickr.photos.search"
let kFlickrGroupID = "&group_id=1463451%40N25"
let kFlickrPage = "&per_page=1"
let kFlickrJSONCallBack = "&nojsoncallback=1"

//Segue Constants
let kAddCitySegue = "AddCitySegue"
let kWeatherforecastSegue = "WeatherForecastSegue"

//NSUserDefault key Constant
let kUserDefaultKey = "CityName"

//TableViewCell Constants
let kCityWeatherListCell = "CityWeatherListCell"
let kCityWeatherCell = "CityWeatherCell"
let kSearchCityCell = "SearchCityCell"

//Temperature Unit Button Title
let kTempUnitButtonTitle = "ºC / ºF"

//Date Format Constants
let kY_M_D = "yyyy-mm-dd"
let kD_M_Y = "dd-mm-yyyy"

//Navigation Title
let kAddCityVCTitle = "Search City"
let kCityWeatherListVCTitle = "Weather"

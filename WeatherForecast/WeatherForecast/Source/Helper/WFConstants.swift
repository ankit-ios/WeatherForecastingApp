//
//  WFConstants.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 18/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation

//API Constants
let kBaseURL = "https://api.worldweatheronline.com/premium/v1"
let kAPIKey = "0cbbbbf2ee2344ef90a64938171101"
let kSearchString = "/search.ashx"
let kWeatherString = "/weather.ashx"
let kKeyParam = "?key="
let kNameParam = "&q="
let kFormatParam = "&format=json"
let kDayParam = "&num_of_days=5"
let kDateParam = "&date=today"

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

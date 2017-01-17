//
//  WFCityWeatherViewController.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 17/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import Alamofire

class WFCityWeatherViewController: UIViewController {
    
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentWeatherDescLabel: UILabel!
    @IBOutlet weak var currentWeatherIconImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var city: WFCity?
    var tempUnit: TempUnit = .celsius
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    
    func setupOnLoad() {
        if let city = city {
            title = city.cityName
            let currentWeather = city.currentWeather
            currentWeatherTempLabel.text = tempUnit == .celsius ? "\(currentWeather.currentTempInCelsius) ºC" : "\(currentWeather.currentTempInFahrenheit) ºF"
            currentWeatherDescLabel.text = currentWeather.currentWeatherDesc
            WFWebServiceManager.getWeatherIcon(currentWeather.currentWeatherIconUrl) { imageData, error in
                if let imageData = imageData where error == nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.currentWeatherIconImageView.image = UIImage(data: imageData)
                        self.tableView.reloadData()
                    })
                }
            }
        }
        tableView.tableFooterView = UIView()
    }
    
    func convertDateFormate(date: String) -> String {
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateFormat = "yyyy-mm-dd"
        let date = dateformatter.dateFromString(date)
        
        dateformatter.dateFormat = "dd-mm-yyyy"
        return dateformatter.stringFromDate(date!)
    }
}

extension WFCityWeatherViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city?.forecastWeather.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("CityWeatherCell") as? WFCityWeatherTableViewCell {
            if let weather = city?.forecastWeather[indexPath.row] {
                cell.dateLabel.text = convertDateFormate(weather.date ?? "")
                
                let tempInCelsius = "\(weather.maxTempInCelsius) ºC / \(weather.minTempInCelsius) ºC"
                let tempInFehrenheit = "\(weather.maxTempInFehrenheit) ºF / \(weather.minTempInFehrenheit) ºF"
                cell.tempLabel.text = tempUnit == .celsius ? tempInCelsius : tempInFehrenheit
            }
            return cell
        }
        
        return UITableViewCell()
    }
}









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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var city: WFCity?
    var tempUnit: TempUnit = .celsius
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        currentWeatherIconImageView.image = nil
    }
    
    func setupOnLoad() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background") ?? UIImage())
        tableView.tableFooterView = UIView()

        if let city = city {
            title = city.cityName
            let currentWeather = city.currentWeather
            currentWeatherTempLabel.text = tempUnit == .celsius ? "\(currentWeather.currentTempInCelsius) ºC" : "\(currentWeather.currentTempInFahrenheit) ºF"
            let weatherDesc = currentWeather.currentWeatherDesc
            currentWeatherDescLabel.text = weatherDesc
           
            activityIndicator.startAnimating()
            
            if let backgroundImage = NSCache.sharedInstance.objectForKey(weatherDesc) as? UIImage {
                self.currentWeatherIconImageView.image = backgroundImage
                self.activityIndicator.stopAnimating()
            } else {
                WFWebServiceManager.getImageFromFlickrSearch(weatherDesc.removeSpace, onCompletion: { (response, error) in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.activityIndicator.stopAnimating()
                        if let imageData = response where error == nil {
                            let image = UIImage(data: imageData)
                            self.currentWeatherIconImageView.image = image
                            NSCache.sharedInstance.setObject(image ?? UIImage(), forKey: weatherDesc)
                        } else {
                            self.currentWeatherIconImageView.image = UIImage(named: "placeHolder")
                        }
                    })
                })
            }
        }
    }
    
    
    
    func convertDateFormate(date: String) -> String {
        let dateformatter = NSDateFormatter()
        
        dateformatter.dateFormat = kY_M_D
        let date = dateformatter.dateFromString(date)
        
        dateformatter.dateFormat = kD_M_Y
        return dateformatter.stringFromDate(date ?? NSDate())
    }
}

extension WFCityWeatherViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city?.forecastWeather.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherCell) as? WFCityWeatherTableViewCell {
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









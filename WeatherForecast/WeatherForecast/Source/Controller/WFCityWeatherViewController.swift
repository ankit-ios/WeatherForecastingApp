//
//  WFCityWeatherViewController.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 17/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class WFCityWeatherViewController: UIViewController {
    
    //Outlets
    @IBOutlet private weak var currentWeatherTempLabel: UILabel!
    @IBOutlet private weak var currentWeatherDescLabel: UILabel!
    @IBOutlet private weak var currentWeatherIconImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //Properties
    var city: WFCity?
    var tempUnit: TempUnit = .celsius
    
    
    //View Controller life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    
    override func viewWillDisappear(animated: Bool) {
        currentWeatherIconImageView.image = nil
    }
}

// MARK: - Private Extension
private extension WFCityWeatherViewController {
    
    //setup on loading
    func setupOnLoad() {
        view.backgroundColor = UIColor.defaultBackgroundColor
        tableView?.tableFooterView = UIView()
        initialSetupForUI()
    }
    
    //initial setup
    func initialSetupForUI() {
        if let city = city {
            title = city.cityName
            
            if let currentWeather = city.currentWeather {
                currentWeatherTempLabel.text = tempUnit == .celsius ? "\(currentWeather.currentTempInCelsius ?? "") ºC" : "\(currentWeather.currentTempInFahrenheit ?? "") ºF"
                
                if let weatherDesc = currentWeather.currentWeatherDesc {
                    currentWeatherDescLabel.text = weatherDesc
                    
                    activityIndicator.startAnimating()
                    setBackgroundImage(with: weatherDesc)
                }
            }
        }
    }
    
    //fetching image data from server with weather description
    func setBackgroundImage(with weatherDescription: String) {
        if let backgroundImage = NSCache.sharedInstance.objectForKey(weatherDescription) as? UIImage {
            self.currentWeatherIconImageView.image = backgroundImage
            self.activityIndicator.stopAnimating()
        } else {
            WFWebServiceManager.getImageFromFlickrSearch(weatherDescription.removeSpace, onCompletion: { [weak self] (response, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    self?.activityIndicator.stopAnimating()
                    if let imageData = response where error == nil {
                        if let image = UIImage(data: imageData) {
                            self?.currentWeatherIconImageView.image = image
                            NSCache.sharedInstance.setObject(image, forKey: weatherDescription)
                        }
                    } else {
                        self?.showAlertWithMessage(title: "Error", message: error?.localizedDescription, viewController: self)
                    }
                })
            })
        }
    }
}

// MARK: - UITableView DataSource methods
extension WFCityWeatherViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city?.forecastWeather?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherCell) as? WFCityWeatherTableViewCell {
            if let weather = city?.forecastWeather?[indexPath.row] {
                
                cell.configureCell(with: weather, tempUnit: tempUnit)
            }
            return cell
        }
        return UITableViewCell()
    }
}









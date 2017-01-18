//
//  WFMainViewController.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

enum TempUnit {
    case celsius
    case fahrenheit
}

class WFCityWeatherListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tempUnitButtonOutlet: UIButton!
    
    var cities = [WFCity]()
    let citiesName = ["mangalore,karnataka", "bangalore", "udupi", "gwalior", "datia"]
    var tempUnit: TempUnit = .celsius
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
        changeButtonTextColor()
    }
    
    
    func setupOnLoad() {
        title = "Weather"
        tableView.tableFooterView = UIView()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            for cityName in self.citiesName {
                WFWebServiceManager.getCityWeather(cityName) { [weak self] weather, error in
                    if let weather = weather where error == nil {
                        self?.cities.append(WFCity.constractModel(weather as! [String : AnyObject]))
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherForecastSegue" {
            if let VC = segue.destinationViewController as? WFCityWeatherViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    VC.city = cities[indexPath.row]
                    VC.tempUnit = tempUnit
                }
            }
            
        } else if segue.identifier == "AddCitySegue" {
            
            if let VC = segue.destinationViewController as? WFAddCityViewController {
                VC.delegate = self
            }
        }
    }
    
    @IBAction func changeTempUnit(sender: UIButton) {
        tempUnit = tempUnit == .celsius ? .fahrenheit : .celsius
        changeButtonTextColor()
        tableView.reloadData()
    }
    
    func changeButtonTextColor() {
        let buttonTitle: NSString = "ºC / ºF"
        var mutableButtonTitle = NSMutableAttributedString()
        
        mutableButtonTitle = NSMutableAttributedString(string: buttonTitle as String)
        mutableButtonTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: tempUnit == .celsius ? NSRange(location:0,length:4) : NSRange(location:3,length:4)) //set attribute
        tempUnitButtonOutlet.setAttributedTitle(mutableButtonTitle, forState: .Normal)
    }
}

extension WFCityWeatherListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("CityWeatherListCell", forIndexPath: indexPath) as? WFCityWeatherListTableViewCell {
            cell.cityNameLabel.text = cities[indexPath.row].cityName
            
            let temp = cities[indexPath.row].currentWeather
            let weather = tempUnit == .celsius ? "\(temp.currentTempInCelsius) ºC" : "\(temp.currentTempInFahrenheit) ºF"
            cell.cityWeatherLabel.text = "\(weather)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            cities.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
        }
    }
}

extension WFCityWeatherListVC: WFAddCityViewControllerProtocol {
    
    func cityAdded(city: WFCity) {
        cities.append(city)
        cities = cities.orderedSetValue
        tableView.reloadData()
    }
}


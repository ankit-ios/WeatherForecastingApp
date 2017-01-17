//
//  WFMainViewController.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class WFCityWeatherListVC: UIViewController {
    
    enum TempUnit {
        case celsius
        case fahrenheit
    }
    
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
        
        for cityName in citiesName {
            WFWebServiceManager.getCityWeather(cityName) { weather, error in
                
                print(JSON(weather!))
                print(error)
                
                if let weather = weather where error == nil {
                    self.cities.append(WFCity.constractModelWithJson(weather))
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "WeatherForecastSegue" {
            
            
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
        let myString: NSString = "ºC / ºF"
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: tempUnit == .celsius ? NSRange(location:0,length:4) : NSRange(location:3,length:4)) //set attribute
        tempUnitButtonOutlet.setAttributedTitle(myMutableString, forState: .Normal)
    }
}

extension WFCityWeatherListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("CityWeatherCell", forIndexPath: indexPath) as? WFCityWeatherListTableViewCell {
            cell.cityNameLabel.text = cities[indexPath.row].cityName
            
            let temp = cities[indexPath.row].currentWeather
            let weather = tempUnit == .celsius ? "\(temp.currentTempInCelsius) ºC" : "\(temp.currentTempInFahrenheit) ºF"
            cell.cityWeatherLabel.text = "\(weather)"
            
            return cell
        }
        return UITableViewCell()
    }
}

extension WFCityWeatherListVC: WFAddCityViewControllerProtocol {
    
    func cityAdded(city: WFCity) {
        cities.append(city)
        tableView.reloadData()
    }
}





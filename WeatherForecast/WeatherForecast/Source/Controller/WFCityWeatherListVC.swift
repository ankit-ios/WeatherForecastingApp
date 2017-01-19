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
    var citiesName = [String]()
    var tempUnit: TempUnit = .celsius
    
    let userDefault = {
        return NSUserDefaults.standardUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
        tableViewInitialSetup()
        changeButtonTextColor()
        fetchWeatherInfoOfAllCities()
    }
    
    override func viewWillAppear(animated: Bool) {
        setEditing(false, animated: true)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
        
    }
    
    func setupOnLoad() {
        title = kCityWeatherListVCTitle
        navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let citiesName = getCityName() as? [String] {
            self.citiesName = citiesName.filter({ cityName in
                return cityName != ""
            })
        }
    }
    
    func fetchWeatherInfoOfAllCities() {
        for cityName in self.citiesName {
            WFWebServiceManager.getCityWeather(cityName) { [weak self] weather, error in
                if let weather = weather where error == nil {
                    self?.cities.append(WFCity.constructModel(weather as! [String : AnyObject]))
                    self?.tableView.reloadData()
                }
                else {
                    print(error)
                }
            }
        }
    }
    
    func saveCityName(object: AnyObject) {
        userDefault().setObject(citiesName, forKey: kUserDefaultKey)
        userDefault().synchronize()
    }
    
    func getCityName() -> AnyObject? {
        return userDefault().objectForKey(kUserDefaultKey)
    }
    
    func tableViewInitialSetup() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kWeatherforecastSegue {
            if let VC = segue.destinationViewController as? WFCityWeatherViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    VC.city = cities[indexPath.row]
                    VC.tempUnit = tempUnit
                }
            }
        } else if segue.identifier == kAddCitySegue {
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
        let buttonTitle: NSString = kTempUnitButtonTitle
        var mutableButtonTitle = NSMutableAttributedString()
        
        mutableButtonTitle = NSMutableAttributedString(string: buttonTitle as String)
        mutableButtonTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: tempUnit == .celsius ? NSRange(location:0,length:4) : NSRange(location:3,length:4))
        tempUnitButtonOutlet.setAttributedTitle(mutableButtonTitle, forState: .Normal)
    }
}

extension WFCityWeatherListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherListCell, forIndexPath: indexPath) as? WFCityWeatherListTableViewCell {
            cell.cityNameLabel.text = cities[indexPath.row].cityName
            
            let temp = cities[indexPath.row].currentWeather
            let weather = tempUnit == .celsius ? "\(temp.currentTempInCelsius) ºC" : "\(temp.currentTempInFahrenheit) ºF"
            cell.cityWeatherLabel.text = "\(weather)"
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            //delete from data source
            cities.removeAtIndex(indexPath.row)
            citiesName.removeAtIndex(indexPath.row)
            saveCityName(citiesName)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension WFCityWeatherListVC: WFAddCityViewControllerProtocol {
    
    func cityAdded(city: WFCity) {
        cities.append(city)
        cities = cities.removeDuplicate //remove duplicate
        
        citiesName.append(city.cityName)
        citiesName.removeDuplicate//remove duplicate
        saveCityName(citiesName)
        
        tableView.reloadData()
    }
}


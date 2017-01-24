//
//  WFMainViewController.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 16/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import UIKit

/**
 This TempUnit is used for getting temperature unit
 
 - celsius: celsius unit
 - fahrenheit: fahrenheit unit
 */
enum TempUnit {
    case celsius
    case fahrenheit
}

/// This view controller is act, showing all cities in list with temperature
class WFCityWeatherListViewController: UIViewController {
    
    //Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tempUnitButton: UIButton!
    
    //Private properties
    private var cities: [WFCity]?
    private var citiesName = [String]()
    private var tempUnit: TempUnit = .celsius
    private var refreshController: UIRefreshControl?
    
    private let userDefault = {
        return NSUserDefaults.standardUserDefaults()
    }
    
    
    //View Controller life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        setEditing(false, animated: true)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(editing, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kWeatherforecastSegue {
            if let VC = segue.destinationViewController as? WFCityWeatherViewController {
                if let indexPath = tableView.indexPathForSelectedRow, let city = cities?[indexPath.row] {
                    VC.city = city
                    VC.tempUnit = tempUnit
                }
            }
        } else if segue.identifier == kAddCitySegue {
            if let VC = segue.destinationViewController as? WFAddCityViewController {
                VC.delegate = self
            }
        }
    }
    
    //Button action method
    @IBAction func tempUnitButtonTapped(sender: UIButton) {
        tempUnit = tempUnit == .celsius ? .fahrenheit : .celsius
        changeButtonTextColor()
        tableView.reloadData()
    }
}

// MARK: - Private Extension
private extension WFCityWeatherListViewController {
    
    //setup on loading
    func setupOnLoad() {
        title = kCityWeatherListVCTitle
        view.backgroundColor = UIColor.defaultBackgroundColor
        navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //initialize properties
        cities = [WFCity]()
        
        tableView.initialSetup()
        changeButtonTextColor()
        setupRefreshController()
        fetchWeatherInfoOfAllCities()
    }
    
    //change button title text color
    func changeButtonTextColor() {
        let buttonTitle: NSString = kTempUnitButtonTitle
        var mutableButtonTitle = NSMutableAttributedString()
        
        mutableButtonTitle = NSMutableAttributedString(string: buttonTitle as String)
        mutableButtonTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: tempUnit == .celsius ? NSRange(location:0,length:4) : NSRange(location:3,length:4))
        tempUnitButton.setAttributedTitle(mutableButtonTitle, forState: .Normal)
    }
    
    //setup refresh Controller for updating cities Weather
    func setupRefreshController() {
        refreshController = UIRefreshControl()
        
        refreshController?.tintColor = UIColor.whiteColor()
        let attribute = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(20)]
        refreshController?.attributedTitle = NSAttributedString(string: kRefresh, attributes: attribute)
        
        refreshController?.addTarget(self, action: #selector(WFCityWeatherListViewController.refreshCitiesWeather(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshController!)
    }
    
    @objc func refreshCitiesWeather(sender: AnyObject) {
        self.fetchWeatherInfoOfAllCities()
        refreshController?.endRefreshing()
    }
    
    func fetchWeatherInfoOfAllCities() {
        
        //getting citiesName from userDefault
        if let citiesName = getCitiesName() as? [String] {
            self.citiesName = citiesName.filter({ cityName in
                return cityName != ""
            }).removeDuplicate
        }
        
        //getting cities weather from server
        for cityName in citiesName {
            WFWebServiceManager.getCityWeather(cityName) { [weak self] city, error in
                if let city = city where error == nil {
                    self?.cities?.append(city)
                    self?.cities = self?.cities?.removeDuplicate
                    self?.tableView.reloadData()
                } else {
                    self?.cities = [WFCity]()
                    self?.tableView.reloadData()
                    self?.showAlertController(error)
                }
            }
        }
    }
    
    //show alert controller
    func showAlertController(error: NSError?) {
        if let _ = self.navigationController?.visibleViewController as? UIAlertController {
            return
        } else {
            showAlertWithMessage(title: kError, message: error?.localizedDescription, viewController: self)
        }
    }
    
    //save citiesName in userDefault
    func saveCitiesName(object: AnyObject?) {
        if let object = object {
            userDefault().setObject(object, forKey: kUserDefaultKey)
            userDefault().synchronize()
        }
    }
    
    //getting citiesName from userDefault
    func getCitiesName() -> AnyObject? {
        return userDefault().objectForKey(kUserDefaultKey)
    }
    
    //creating table view cell
    func createCell(with indexPath: NSIndexPath) -> WFCityWeatherListTableViewCell? {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kCityWeatherListCell, forIndexPath: indexPath) as? WFCityWeatherListTableViewCell {
            if let city = cities?[indexPath.row] {
                cell.configureCell(with: city, tempUnit: tempUnit)
                return cell
            }
        }
        return nil
    }
    
    //delete cell and delete selected city weather
    func deleteCityFromDataSource(with indexPath: NSIndexPath) {
        let deletedCityName = citiesName[indexPath.row] ?? ""
        //delete from data source
        cities?.removeAtIndex(indexPath.row)
        citiesName.removeAtIndex(indexPath.row)
        saveCitiesName(citiesName)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        //Alert message
        self.showAlertWithMessage(title: kAlert, message: "\(deletedCityName) City Deleted.", viewController: self)
    }
}

// MARK: - UITableView DataSource and UITableView Delegate methods
extension WFCityWeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return createCell(with: indexPath) ?? UITableViewCell()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //delete city from data source
        if editingStyle == .Delete {
            deleteCityFromDataSource(with: indexPath)
        }
    }
}

// MARK: - conferm WFAddCityViewControllerProtocol protocol
extension WFCityWeatherListViewController: WFAddCityViewControllerProtocol {
    
    //adding city in DataSource
    func didAddNewCityName(cityName: String) {
        if !citiesName.contains(cityName) {
            self.citiesName.append(cityName)
            saveCitiesName(citiesName)
            
            WFWebServiceManager.getCityWeather(cityName.removeSpace) {[weak self] (newCityWeather, error) in
                
                if let newCityWeather = newCityWeather {
                    self?.cities?.append(newCityWeather)
                    self?.tableView.reloadData()
                }
            }
        }
    }
}


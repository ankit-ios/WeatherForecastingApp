//
//  WFAddCityViewController.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

class WFAddCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchDelayed: NSTimer?
    var searchedCity = [SearchedCity]()
    
    
}

extension WFAddCityViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCity.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("SearchCityCell") {
            let cellLabel = cell.viewWithTag(1) as? UILabel
            let city = searchedCity[indexPath.row]
            cellLabel?.text = "\(city.cityName), \(city.cityRegion), \(city.cityCountry)"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        
    }
}

extension WFAddCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchCity(searchBar.text ?? "")
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelayed?.invalidate()
        searchDelayed = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "doDelayedSearch:", userInfo: searchText, repeats: false)
    }
    
    func doDelayedSearch(timer: NSTimer) {
        print(timer.userInfo!)
        searchCity(timer.userInfo as? String ?? "")
    }
    
    func searchCity(text: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        WebServiceManager().getSeachedCities(text) {[weak self] (searchedCity, error) in
            if let searchedCity = searchedCity where error == nil {
                print(searchedCity)
                self?.searchedCity = searchedCity
                dispatch_async(dispatch_get_main_queue(), {
                    self?.tableView.reloadData()
                })
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
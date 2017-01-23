//
//  WFAddCityViewController.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import UIKit

protocol WFAddCityViewControllerProtocol: class {
    func didAddNewCityName(cityName: String)
}

class WFAddCityViewController: UIViewController {
    
    //Outlets
    @IBOutlet private weak var tableView: UITableView!

    //Private properties
    private var searchDelayed: NSTimer?
    private var searchedCity: [WFSearchCity]?
    weak var delegate: WFAddCityViewControllerProtocol?
    
    
    //View Controller life cycles
    override func viewDidLoad() {
        setupOnLoad()
    }
}

// MARK: - Private Extension
private extension WFAddCityViewController {
    
    //setup on loading
    func setupOnLoad() {
        title = kAddCityVCTitle
        view.backgroundColor = UIColor.defaultBackgroundColor
        tableView.initialSetup()
        searchedCity = [WFSearchCity]()
    }
    
    //selector method for delaying in search
    @objc func doDelayedSearch(timer: NSTimer) {
        searchCity(timer.userInfo as? String ?? "")
    }
    
    //after delaying, search city with entered text
    func searchCity(text: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        WFWebServiceManager.getSeachedCities(text) {[weak self] (response, error) in
            
            if let response = response where error == nil {
                if let searchedCities = WFSearchCity.constructModel(response) {
                    self?.searchedCity = searchedCities
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self?.tableView.reloadData()
                })
            } else {
                self?.showAlertWithMessage(title: "Error", message: error?.localizedDescription, viewController: self)
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    //show alert controller
    func showAlert(title title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { alertVC in
            alertController.dismissViewControllerAnimated(true, completion: nil)
            
            //dismiss WFAddCityViewController
            self.navigationController?.popViewControllerAnimated(true)
        }))
        return alertController
    }
}

// MARK: - UITableView DataSource and UITableView Delegate methods
extension WFAddCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedCity?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(kSearchCityCell) as? WFAddCityTableViewCell {
            if let searchCity = searchedCity?[indexPath.row] {
                cell.configureCell(with: searchCity)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        if let searchedCity = searchedCity?[indexPath.row] {
            let urlString = "\(searchedCity.cityName ?? ""), \(searchedCity.cityCountry ?? "")"
            delegate?.didAddNewCityName(urlString)
            
            //show alert controller
            let alertVC = self.showAlert(title: "Alert", message: "\(urlString) City Added.")
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UISearchBar Delegate methods
extension WFAddCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchCity(searchBar.text ?? "")
        view.endEditing(true)
    }
    
    //delaying in serach 
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelayed?.invalidate()
        searchDelayed = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(WFAddCityViewController.doDelayedSearch(_:)), userInfo: searchText, repeats: false)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
}
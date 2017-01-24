//
//  WFAddCityViewController.swift
//  WeatherForecastingApp
//
//  Created by Ankit Sharma on 11/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import UIKit

/// This protocol is act for adding new searched city.
protocol WFAddCityViewControllerProtocol: class {
    func didAddNewCityName(cityName: String)
}

/// This WFAddCityViewController is used for search cities.
class WFAddCityViewController: UIViewController {
    
    //Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //Private properties
    private var searchDelayed: NSTimer?
    private var searchCity: [WFSearchCity]?
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
        searchCity = [WFSearchCity]()
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
                self?.searchCity = response
                dispatch_async(dispatch_get_main_queue(), {
                    self?.tableView.reloadData()
                })
            } else {
                self?.searchCity = nil
                self?.tableView.reloadData()
                self?.showAlertWithMessage(title: kError, message: error?.localizedDescription, viewController: self)
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    //show alert controller
    func showAlert(title title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: kOK, style: .Default, handler: { alertVC in
            alertController.dismissViewControllerAnimated(true, completion: nil)
            
            //dismiss WFAddCityViewController
            self.navigationController?.popViewControllerAnimated(true)
        }))
        return alertController
    }
    
    func createCell(with indexPath: NSIndexPath) -> WFAddCityTableViewCell? {
        if let cell = tableView.dequeueReusableCellWithIdentifier(kSearchCityCell) as? WFAddCityTableViewCell {
            if let searchCity = searchCity?[indexPath.row] {
                cell.configureCell(with: searchCity)
                return cell
            }
        }
        return nil
    }
}

// MARK: - UITableView DataSource and UITableView Delegate methods
extension WFAddCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCity?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return createCell(with: indexPath) ?? UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        if let searchCity = searchCity?[indexPath.row] {
            let urlString = "\(searchCity.cityName ?? ""), \(searchCity.cityCountry ?? "")"
            delegate?.didAddNewCityName(urlString)
            
            //show alert controller
            let alertVC = self.showAlert(title: kAlert, message: "\(urlString) City Added.")
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
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    //delaying in serach
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.characters.count < 1 {
            searchBar.resignFirstResponder()
        }
        searchDelayed?.invalidate()
        searchDelayed = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(WFAddCityViewController.doDelayedSearch(_:)), userInfo: searchText, repeats: false)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
}
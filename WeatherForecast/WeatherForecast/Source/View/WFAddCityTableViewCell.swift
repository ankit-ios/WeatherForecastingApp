//
//  WFAddCityTableViewCell.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 22/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

/// WFCityWeatherTableViewCell table view cell
class WFAddCityTableViewCell: UITableViewCell {

    @IBOutlet private weak var cityNameLabel: UILabel!
    
    func configureCell(with searchedCity: WFSearchCity) {
        cityNameLabel.text = "\(searchedCity.cityName ?? "") \(searchedCity.cityRegion ?? "") \(searchedCity.cityCountry ?? "")"
    }
}

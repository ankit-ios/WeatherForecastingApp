//
//  Extensions+WeatherForecast.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 17/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

//Array extension
extension Array where Element: Equatable {
    var orderedSetValue: Array {
        return reduce([]){ $0.contains($1) ? $0 : $0 + [$1]}
    }
}

//String Extension
extension String {
    var removeSpace: String {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "+") ?? self
    }
}
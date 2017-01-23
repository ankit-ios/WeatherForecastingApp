//
//  Extensions+WFUtility.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 17/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import Foundation
import UIKit

//Array extension
//remove duplicates from Array and return newly Array
extension Array where Element: Equatable {
    var removeDuplicate: Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1]}
    }
}

//String Extension
//remove duplicates from String and return String
extension String {
    var removeSpace: String {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "+") ?? self
    }
}

//NSCache Extension
//return static cache for storing downloded images
extension NSCache {
    class var sharedInstance: NSCache {
        struct Static {
            static let instance = NSCache()
        }
        return Static.instance
    }
}

//UITableView Extension
//initial setup of tableview
extension UITableView {
    func initialSetup() {
        self.tableFooterView = UIView()
        self.estimatedRowHeight = 60.0
        self.rowHeight = UITableViewAutomaticDimension
    }
}

//UIColor Extension
//return background color
extension UIColor {
    class var defaultBackgroundColor: UIColor {
        return UIColor(patternImage: UIImage(named: "background") ?? UIImage())
    }
}

//UIViewController Extension
//show alert controller with single message
extension UIViewController {
    func showAlertWithMessage(title title: String?, message: String?, viewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        viewController?.presentViewController(alertController, animated: true, completion: nil)
    }
}










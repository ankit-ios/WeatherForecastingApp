//
//  WFError.swift
//  WeatherForecast
//
//  Created by Ankit Sharma on 23/01/17.
//  Copyright © 2017 Robosoft Technology. All rights reserved.
//

import UIKit

/**
 *  This Struct is used for getting NSError
 */
struct WFError {
    static func getWrongDataError() -> NSError {
        let userInfo: [NSObject : AnyObject] = ["NSLocalizedDescriptionKey" :  NSLocalizedString("WrongData", comment: ""),]
        return NSError(domain: "Unprocessable Entity", code: 422, userInfo: userInfo)
    }
    
    static func getServerError() -> NSError {
        let userInfo: [NSObject : AnyObject] = ["NSLocalizedDescriptionKey" :  NSLocalizedString("Unauthorized", comment: ""),]
        return NSError(domain: "unauthorized", code: 401, userInfo: userInfo)
    }
}




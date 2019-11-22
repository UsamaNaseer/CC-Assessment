//
//  ApiConstants.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation

enum ApiConstants {
    static let weatherBaseURL = "https://api.openweathermap.org/"
    static let resturantBaseURL = "https://maps.googleapis.com/"
    static let weather = "data/2.5/forecast"
    static let resturant = "/maps/api/place/nearbysearch/json"
    static let APIKEY = "AIzaSyA_4_ZncFAl9IK0WwEXh2wkPMKCveYD878"
    static let WeatherAPPID = "d0b56cd8d0ba96474f6afa019756844d"
    static let imageBaseURL = "https://maps.googleapis.com/maps/api/place/photo?"
    static let weatherImageBaseURL = "http://openweathermap.org/img/w/"
}

enum AppConstants {
    static let dateFormat = "yyyy-MM-dd HH:mm:ss"
    static let defaultDateValue  = "0000-00-00 00:00:00"
    static let timeFormat = "HH:mm:ss"
    static let day = "EEEE"
}

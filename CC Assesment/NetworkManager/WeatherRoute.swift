//
//  WeatherRoute.swift
//  CC Assesment
//
//  Created by Usama Naseer on 21/11/2019.
//  Copyright © 2019 Usama Naseer. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRoute : URLRequestBuilder {
    case weather(input: WeatherInput)
}

extension WeatherRoute {
    var mainURL: URL  {
        return URL(string: ApiConstants.weatherBaseURL)!
    }
    
    
    var path: String {
        switch self {
        case .weather:
            return ApiConstants.weather
        }
    }
    
    var parameters: Parameters? {
        var params = Parameters()
        switch self {
        case .weather(let weatherInput):
            params["lat"] = weatherInput.lat
            params["lon"] = weatherInput.long
            params["appid"] = ApiConstants.WeatherAPPID
            return params
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }
    
    
}
